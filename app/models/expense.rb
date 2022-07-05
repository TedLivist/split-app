class Expense < ApplicationRecord
  belongs_to :user

  validates :date, :description, :amount, presence: true
  validates :amount, numericality: { greater_than: 0 }

  has_many :debts, dependent: :destroy

  has_many :debtors, through: :debts, source: :debtor
  has_many :creditors, through: :debts, source: :creditor

  def allocate_debt_evenly(debtors_array, debt_amount)
    debtors_array.each do |debtor|
      debt = Debt.new(creditor_id: self.user_id, debtor_id: debtor.id, amount_owed: debt_amount, expense_id: self.id)
      debt.save
    end
  end

  def allocate_debt_by_amount(debtors_array, amounts_array)
    position = 0
    debtors_array.each do |debtor|
      debt = Debt.new(creditor_id: self.user_id, debtor_id: debtor["id"], amount_owed: amounts_array[position].to_f, expense_id: self.id)
      debt.save
      position += 1
    end
  end
end
