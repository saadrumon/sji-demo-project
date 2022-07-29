class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :first_name, presence: true, length: { maximum: 250 }
  validates :last_name, presence: true, length: { maximum: 250 }
  validates :payment_method, presence: true

  BANK_ACCOUNT = 0
  CARD = 1

  enum payment_method: {
    bank_account: BANK_ACCOUNT,
    card: CARD
  }
end
