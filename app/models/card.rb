class Card < ApplicationRecord
  belongs_to :user
  belongs_to :payment, optional: true

  validates :card_number, presence: true, length: { maximum: 16 }
  validates :card_holder_name, presence: true, length: { maximum: 250 }
  validates :card_type, presence: true
  validates :expiration_date, presence: true

  MASTERCARD = 0
  VISA_CARD = 1
  AMERICAN_EXPRESS = 2

  enum card_type: {
    Mastercard: MASTERCARD,
    Visa_card: VISA_CARD,
    American_express: AMERICAN_EXPRESS
  }
end
