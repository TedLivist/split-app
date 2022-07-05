class DebtsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_session_variables, only: [:new]

  def index
    @debts = current_user.debts.select { |d| d.amount_owed > 0 }

    @debts
  end

  def new
    @debtors = session[:debtors]
    if @debtors.empty?
      flash[:notice] = "Expense created successfully"
      redirect_to root_path
    end
    session[:errors]
  end

  def create
    session[:errors] = []
    expense = Expense.find_by(id: session[:expense_id])
    amount = expense.amount
    split_total = params[:split].values.map { |v| v.to_f }.sum
    
    if split_total > amount
      session[:errors] << "Total split amount cannot be more than expense amount"
      redirect_to new_debt_path and return
    else
      expense.allocate_debt_by_amount(session[:debtors], params[:split].values)
      clear_session_variables
      flash[:notice] = 'Expense split successfully'
      redirect_to root_path and return
    end
  end

  def edit
    @debt = Debt.find_by(id: params[:id])
  end

  def update
    @debt = Debt.find_by(id: params[:id])
    counter_balance = @debt.amount_owed.to_f - params[:debt][:amount_owed].to_f
    if counter_balance < 0
      @debt.errors.add(:overpayment, "is not allowed")
      render 'edit'
    else
      @debt.update(amount_owed: counter_balance)
      flash[:notice] = 'Repayment done successfully'
      redirect_to debts_path
    end
  end
end