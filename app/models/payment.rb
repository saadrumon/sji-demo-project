class Payment < ApplicationRecord
  after_save :set_purchase_status

  belongs_to :purchase
  has_one :bank_account, dependent: :nullify
  has_one :card, dependent: :nullify

  INCOMPLETE = 0
  PENDING = 1
  COMPLETED = 2

  enum status: {
    Incomplete: INCOMPLETE,
    Pending: PENDING,
    Completed: COMPLETED
  }

  DEFAULT = 0
  BANK_ACCOUNT = 1
  CARD = 2

  enum method: {
    Default: DEFAULT,
    Bank_account: BANK_ACCOUNT,
    Card: CARD
  }

  def set_purchase_status
    purchase.update(status: Purchase::IN_REVIEW) if Pending?
  end

  def adjust_amount
    self.status = Payment::COMPLETED
    payable_amount = self.purchase.payable_amount
    refund_amount = self.purchase.user.refund_amount
    paid_amount = self.purchase.paid_amount
    if self.amount >= payable_amount
      self.purchase.update(payable_amount: 0)
      self.purchase.user.update(refund_amount: refund_amount + self.amount - payable_amount)
      self.purchase.update(paid_amount: self.purchase.amount)
      self.purchase.update(status: Purchase::PAID)
    else
      self.purchase.update(payable_amount: payable_amount - self.amount)
      self.purchase.update(paid_amount: paid_amount + self.amount)
      self.purchase.update(status: Purchase::UNPAID)
    end
    save!
  end
end
