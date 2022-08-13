class CardsController < ApplicationController
  before_action :set_card, only: %i[edit update]

  def new
    @card = current_user.build_card
  end

  def create
    @card = current_user.build_card(card_params)
    if @card.save
      current_user.bank_account&.destroy
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
    @card = current_user.card
  end

  def card_params
    params.require(:card).permit(
      :card_type,
      :card_holder_name,
      :card_number,
      :expiration_date
    )
  end
end
