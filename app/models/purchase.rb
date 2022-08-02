class Purchase < ApplicationRecord
  before_create :set_amount

  belongs_to :user
  PAY_NOW = 0
  PAY_LATER = 1

  enum payment_type: {
    Pay_now: PAY_NOW,
    Pay_later: PAY_LATER
  }

  UNPAID = 0
  PAID = 1
  WITHDRAW = 2

  enum status: {
    Unpaid: UNPAID,
    Paid: PAID,
    Withdraw: WITHDRAW
  }

  def adjust_amount(adjustment_amount)
    if adjustment_amount > amount
      status = UNPAID
    elsif adjustment_amount < amount
      status = WITHDRAW
    else
      status = PAID
    end
    self.payable_amount = adjustment_amount - (Paid? ? amount : 0)
    self.amount = adjustment_amount
    save!
  end

  def set_amount
    self.amount = volume.to_f * ENV["FUEL_COST_PER_VOLUME"].to_f
    self.payable_amount = amount
    self.status = Purchase::UNPAID
  end
end
