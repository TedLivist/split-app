class ExpensesController < ApplicationController
  before_action :authenticate_user!
  before_action :expense_params, only: :create

  def new
    @expense = Expense.new
  end

  def create
    @expense = Expense.new(expense_params)
    if @expense.valid?
      @expense.save
      session[:expense_id] = @expense.id
      session[:expense_amount] = @expense.amount
      spender_id = params[:user_id]
      debtors_array = []
      expense = params[:expense]
      debtors = params[:debtor_ids].drop(1) if params[:debtor_ids].present?

      if debtors.present?
        debtors.each do |debtor_id|
          unless debtor_id == spender_id
            debtors_array << User.find_by(id: debtor_id)
          end
        end
        session[:debtors] = debtors_array
      end
  
      if expense == '1'
        split_type = params[:split]
        case split_type
          when "Share evenly"
            even_split_amount = session[:expense_amount]/(session[:debtors].size + 1)
            @expense.allocate_debt_evenly(session[:debtors], even_split_amount.round(2))
            clear_session_variables
            
            flash[:notice] = "Expense split evenly"
            redirect_to root_path and return
          when "Share by amount"
            redirect_to new_debt_path and return
        end
      end
    else
      render 'new' and return
    end
    flash[:notice] = "Expense created successfully"
    redirect_to root_path and return
  end
  
  private

  def expense_params
    params.permit(:date, :description, :user_id, :amount)
  end
end