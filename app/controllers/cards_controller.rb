class CardsController < ApplicationController
  before_action :set_card, only: %i[edit update]

  def new
    @card = Card.new
  end

  def create
    @card = Card.new(card_params)
    @current_user = current_user
    if @card.save
      @current_user.card_id = @card.id
      bank_account = nil
      if @current_user.bank_account_id
        bank_account = BankAccount.find(@current_user.bank_account_id)
        @current_user.bank_account_id = nil
      end
      @current_user.save!
      bank_account.destroy if bank_account
      redirect_to root_path,
                  notice: 'Card saved successfully'
    else
      render :new
    end
  end

  def edit; end

  def update
    if @card.update(card_params)
      redirect_to root_path,
          notice: "Card was successfully updated."
    else
      render :edit
    end
  end

  private
  def set_card
    @card = Card.find(params[:id])
  end

  def card_params
    params.require(:card).permit(:card_id,
                                         :card_type,
                                         :card_holder_name,
                                         :card_number,
                                         :expiration_date)
  end
end
