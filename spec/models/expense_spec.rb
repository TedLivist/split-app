require 'rails_helper'

RSpec.describe "Expense", type: :model do
  let!(:users) { Fabricate.times(3, :user) }
  let!(:expense) { Fabricate(:expense, user: users.first, amount: 30.0) }

  context "When an expense is split evenly" do
    it "splits the expense evenly" do
      second_user = User.second
      third_user = User.third
     
      expense.allocate_debt_evenly([second_user, third_user], 10)
      second_user_debt = second_user.debts.first.amount_owed
      third_user_debt = third_user.debts.first.amount_owed

      expect(second_user_debt).to eq(10.0)
      expect(third_user_debt).to eq(10.0)  
    end
  end

  context "When an expense is split by amount" do
    it "splits the expense based on expense" do
      second_user = User.second
      third_user = User.third

      expense.allocate_debt_by_amount([second_user, third_user], [15, 5])
      second_user_debt = second_user.debts.first.amount_owed
      third_user_debt = third_user.debts.first.amount_owed

      expect(second_user_debt).to eq(15.0)
      expect(third_user_debt).to eq(5.0)
    end
  end
end
