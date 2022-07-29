class AddIsAdminCardBankAccountToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :is_admin, :boolean, default: false
    add_reference :users, :bank_account, foreign_key: true
    add_reference :users, :card, foreign_key: true
  end
end
