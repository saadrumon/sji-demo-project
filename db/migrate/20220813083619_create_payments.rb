class CreatePayments < ActiveRecord::Migration[6.1]
  def change
    create_table :payments do |t|
      t.string :transaction_code
      t.integer :status
      t.integer :method
      t.float :amount
      t.references :purchase, null: false, foreign_key: true

      t.timestamps
    end
  end
end
