class AddColumnsToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :payment_method, :integer
    add_column :users, :refund_amount, :float, default: 0
    add_column :users, :is_admin, :boolean, default: false
  end
end
