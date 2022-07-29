class CardsController < ApplicationController
  def new
    @card = Card.new
  end

  def create
    @card = Card.new(card_params)
    @current_user = current_user
    if @card.save
      @current_user.card_id = @card.id
      @current_user.save
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
