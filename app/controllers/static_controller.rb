class StaticController < ApplicationController
  def dashboard
    @user_debts = current_user.total_debts
    @user_credits = current_user.total_credits
    @user_balance = @user_credits - @user_debts

    @user_owes = current_user.owes
    @user_owed = current_user.owed
  end

  def person
    person = User.find_by(id: params[:id])

    @person_credits = person.credits
    @person_debts = person.debts
  end
end
