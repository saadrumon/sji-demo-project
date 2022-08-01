class BankAccountsController < ApplicationController
  before_action :set_bank_account, only: %i[edit update]

  def new
    @bank_account = BankAccount.new
  end

  def create
    @bank_account = BankAccount.new(bank_account_params)
    @current_user = current_user
    if @bank_account.save
      @current_user.bank_account_id = @bank_account.id
      card = nil
      if @current_user.card_id
        card = Card.find(@current_user.card_id)
        @current_user.card_id = nil
      end
      @current_user.save!
      card.destroy if card
      redirect_to root_path,
                  notice: 'Bank account save successfully'
    else
      render :new
    end
  end

  def edit; end

  def update
    if @bank_account.update(bank_account_params)
      redirect_to root_path,
          notice: "Bank account was successfully updated."
    else
      render :edit
    end
  end
  
  private
  def set_bank_account
    @bank_account = BankAccount.find(params[:id])
  end

  def bank_account_params
    params.require(:bank_account).permit(:bank_account_id,
                                           :bank_name,
                                           :routing_number,
                                           :account_holder_name,
                                           :account_number)
  end
end
