class CreateBankAccounts < ActiveRecord::Migration[6.1]
  def change
    create_table :bank_accounts do |t|
      t.string :bank_name
      t.string :routing_number
      t.string :account_holder_name
      t.string :account_number
      t.references :user, null: false, foreign_key: true
      t.boolean :is_default, default: false

      t.timestamps
    end
  end
end
