class CreatePurchases < ActiveRecord::Migration[6.1]
  def change
    create_table :purchases do |t|
      t.references :user, null: false, foreign_key: true
      t.float :volume
      t.float :amount
      t.integer :status
      t.integer :payment_type
      t.float :adjustment_amount

      t.timestamps
    end
  end
end
