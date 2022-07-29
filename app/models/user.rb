class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  BANK_ACCOUNT = 0
  CARD = 1

  enum payment_method: {
    bank_account: BANK_ACCOUNT,
    card: CARD
  }
end
