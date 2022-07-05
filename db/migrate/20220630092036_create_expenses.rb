class CreateExpenses < ActiveRecord::Migration[6.1]
  def change
    create_table :expenses do |t|
      t.date :date
      t.text :description
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
