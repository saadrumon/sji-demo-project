class PaymentsController < ApplicationController
  before_action :set_purchase, only: %i[new create show edit update bank_account save_bank_account card save_card verify]
  before_action :set_payment, only: %i[show edit update bank_account save_bank_account card save_card verify]

  def index
    @payments = current_user.get_payments
  end

  def new
    @payment = @purchase.payments.new
  end

  def create
    @payment = @purchase.payments.new(payment_params)
    @payment.amount = @purchase.payable_amount
    if @payment.save!
      if payment_params[:method].eql? "Bank_account"
        @payment.update(status: Payment::INCOMPLETE)
        @bank_account = @payment.build_bank_account
        render :bank_account
      elsif payment_params[:method].eql? "Card"
        @payment.update(status: Payment::INCOMPLETE)
        @card = @payment.build_card
        render :card
      else
        @payment.update(status: Payment::PENDING)
        @payment.update(method: current_user.Bank_account? ? Payment::BANK_ACCOUNT : Payment::CARD)
        if current_user.Bank_account?
          bank_account = current_user.default_bank_account.dup
          bank_account.is_default = false
          bank_account.payment = @payment
          bank_account.save!
        elsif current_user.Card?
          card = current_user.default_card.dup
          card.is_default = false
          card.payment = @payment
          card.save!
        end
        redirect_to payments_path,
                    notice: 'Payment is waiting for verification'
      end
    else
      render :new
    end
  end

  def show; end

  def edit; end

  def update
    if @payment.update(payment_params)
      redirect_to payments_path,
          notice: 'Payment is waiting for verification'
    else
      render :edit
    end
  end

  def verify
    @payment.adjust_amount
    redirect_to payments_path,
      notice: 'Payment is verified'
  end

  def bank_account; end

  def save_bank_account
    @bank_account = @payment.build_bank_account(bank_account_params)
    @bank_account.user = current_user
    if @bank_account.save!
      @payment.update(status: Payment::PENDING)
      redirect_to payments_path,
        notice: 'Payment is waiting for verification'
    else
      render :bank_account
    end
  end

  def card; end

  def save_card
    @card = @payment.build_card(card_params)
    @card.user = current_user
    if @card.save!
      @payment.update(status: Payment::PENDING)
      redirect_to payments_path,
        notice: 'Payment is waiting for verification'
    else
      render :card
    end
  end

  private
  def set_purchase
    @purchase = Purchase.find(params[:purchase_id])
  end

  def set_payment
    @payment = Payment.find(params[:id])
  end

  def payment_params
    params.require(:payment).permit(
      :amount,
      :transaction_code,
      :method
    )
  end

  def bank_account_params
    params.require(:bank_account).permit(
      :bank_name,
      :routing_number,
      :account_holder_name,
      :account_number,
      :is_default
    )
  end

  def card_params
    params.require(:card).permit(
      :card_type,
      :card_holder_name,
      :card_number,
      :expiration_date,
      :is_default
    )
  end
end
