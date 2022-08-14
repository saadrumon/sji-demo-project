class AddPaymentToBankAccount < ActiveRecord::Migration[6.1]
  def change
    add_reference :bank_accounts, :payment, foreign_key: true
  end
end
