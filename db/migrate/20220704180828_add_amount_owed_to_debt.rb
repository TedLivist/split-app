class AddAmountOwedToDebt < ActiveRecord::Migration[6.1]
  def change
    add_column :debts, :amount_owed, :decimal
    #Ex:- add_column("admin_users", "username", :string, :limit =>25, :after => "email")
  end
end
