class CardsController < ApplicationController
  before_action :set_card, only: %i[edit update]

  def new
    @card = current_user.cards.new
  end

  def create
    @card = current_user.cards.new(card_params)
    if @card.save
      if card_params[:is_default].eql? "true"
        current_user.update(payment_method: User::CARD)
        current_user.default_bank_account&.update(is_default: false)
      end
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
    params.require(:card).permit(
      :card_type,
      :card_holder_name,
      :card_number,
      :expiration_date,
      :is_default
    )
  end
end
