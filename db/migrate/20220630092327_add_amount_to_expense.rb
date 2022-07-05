class AddAmountToExpense < ActiveRecord::Migration[6.1]
  def change
    add_column :expenses, :amount, :integer
  end
end
