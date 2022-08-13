class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :purchases, dependent: :destroy
  has_one :bank_account, dependent: :destroy
  has_one :card, dependent: :destroy

  validates :first_name, presence: true, length: { maximum: 250 }
  validates :last_name, presence: true, length: { maximum: 250 }
  validates :payment_method, presence: true, unless: -> { is_admin }
  validates :email, format: URI::MailTo::EMAIL_REGEXP

  BANK_ACCOUNT = 0
  CARD = 1

  enum payment_method: {
    Bank_account: BANK_ACCOUNT,
    Card: CARD
  }

  def is_admin?
    is_admin == true
  end

  def self.authenticate(email, password)
    user = User.find_for_authentication(email: email)
    user&.valid_password?(password) ? user : nil
  end
end
