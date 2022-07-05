class CreateDebts < ActiveRecord::Migration[6.1]
  def change
    create_table :debts do |t|
      t.integer :creditor_id
      t.integer :debtor_id
      t.references :expense, null: false, foreign_key: true

      t.timestamps
    end
  end
end
