class CardsController < ApplicationController
  def new
    @card = Card.new
  end

  def create
    @card = Card.new(card_params)
    if @card.save
      redirect_to root_path,
                  notice: 'Card save successfully'
    else
      render :new
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private
  def card_params
    params.require(:card).permit(:card_id,
                                         :card_type,
                                         :card_holder_name,
                                         :card_number,
                                         :expiration_date)
  end
end
