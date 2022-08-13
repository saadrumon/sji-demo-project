class Purchase < ApplicationRecord

  belongs_to :user
  has_many :payments, dependent: :destroy

  PAY_NOW = 0
  PAY_LATER = 1

  enum payment_type: {
    Pay_now: PAY_NOW,
    Pay_later: PAY_LATER
  }

  UNPAID = 0
  PAID = 1

  enum status: {
    Unpaid: UNPAID,
    Paid: PAID
  }

  # ToDo: Need to define this mehtod for cost adjustment
  def adjust_amount
  end

  def set_amount(current_user)
    self.amount = volume.to_f * unit_cost.to_f
    deduction_amount = [amount, current_user.refund_amount].min
    self.payable_amount = amount - deduction_amount
    current_user.refund_amount -= deduction_amount
    current_user.save!
    self.status = (payable_amount > 0) ? Purchase::UNPAID : Purchase::PAID
  end
end
