class CreateBankAccounts < ActiveRecord::Migration[6.1]
  def change
    create_table :bank_accounts do |t|
      t.string :bank_name
      t.string :routing_number
      t.string :account_holder_name
      t.string :account_number

      t.timestamps
    end
  end
end
