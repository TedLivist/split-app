class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :expenses
  has_many :debts, foreign_key: 'debtor_id'
  has_many :credits, class_name: 'Debt', foreign_key: 'creditor_id'

  def total_debts
    self.debts.map(&:amount_owed).sum
  end

  def total_credits
    self.credits.map(&:amount_owed).sum
  end

  def owes
    self.debts.order(created_at: 'DESC').limit(3)
  end

  def owed
    self.credits.order(created_at: 'DESC').limit(3)
  end
end