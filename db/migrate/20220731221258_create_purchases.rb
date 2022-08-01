class CreatePurchases < ActiveRecord::Migration[6.1]
  def change
    create_table :purchases do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :volume
      t.integer :amount
      t.integer :status
      t.integer :type

      t.timestamps
    end
  end
end
