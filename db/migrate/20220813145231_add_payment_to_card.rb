class AddPaymentToCard < ActiveRecord::Migration[6.1]
  def change
    add_reference :cards, :payment, foreign_key: true
  end
end