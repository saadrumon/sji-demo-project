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
  IN_REVIEW = 2

  enum status: {
    Unpaid: UNPAID,
    Paid: PAID,
    In_review: IN_REVIEW
  }

  def adjust_amount(unit_cost)
    paid_amount = self.paid_amount
    refund_amount = self.user.refund_amount
    new_amount = unit_cost * self.volume
    if paid_amount >= new_amount
      self.user.update(refund_amount: refund_amount + paid_amount - new_amount)
      self.status = Purchase::PAID
      self.paid_amount = new_amount
      self.payable_amount = 0
    else
      self.payable_amount = new_amount - paid_amount
      deduction_amount = [refund_amount, self.payable_amount].min
      self.payable_amount -= deduction_amount
      self.paid_amount += deduction_amount
      self.user.update(refund_amount: refund_amount - deduction_amount)
      self.status = (self.payable_amount > 0) ? Purchase::UNPAID : Purchase::PAID
    end
    self.amount = new_amount
    save!
  end

  def set_amount(current_user)
    self.amount = volume.to_f * unit_cost.to_f
    deduction_amount = [amount, current_user.refund_amount].min
    self.payable_amount = amount - deduction_amount
    current_user.refund_amount -= deduction_amount
    self.paid_amount = deduction_amount
    current_user.save!
    self.status = (payable_amount > 0) ? Purchase::UNPAID : Purchase::PAID
  end
end
