class BankAccount < ApplicationRecord
  belongs_to :user
  belongs_to :payment, optional: true

  validates :routing_number, presence: true, length: { maximum: 16 }
  validates :account_holder_name, presence: true, length: { maximum: 250 }
  validates :bank_name, presence: true, length: { maximum: 250 }
  validates :account_number, presence: true
end
