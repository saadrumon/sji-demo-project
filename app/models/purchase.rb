class Purchase < ApplicationRecord
  belongs_to :user
  PAY_NOW = 0
  PAY_LATER = 1

  enum payment_type: {
    Pay_now: PAY_NOW,
    Pay_later: PAY_LATER
  }

  UNPAID = 0
  PENDING = 1
  PARTIALLY_PAID = 2
  PAID = 3
  WITHDRAW = 4

  enum status: {
    Unpaid: UNPAID,
    Pending: PENDING,
    Partially_paid: PARTIALLY_PAID,
    Paid: PAID,
    Withdraw: WITHDRAW
  }
  def adjust_amount(adjustment_amount)
    if adjustment_amount > self.amount
      self.status = PARTIALLY_PAID
      self.amount = adjustment_amount - self.amount
    elsif adjustment_amount < self.amount
      self.status = WITHDRAW
      self.amount = self.amount - adjustment_amount
    else
      self.status = PAID
    end
    save
  end
end
