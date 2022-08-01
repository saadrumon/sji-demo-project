class PurchasesController < ApplicationController
  def index
    if current_user.is_admin
      @purchases = Purchase.all
    else
      @purchases = Purchase.where(user_id: current_user.id)
    end
  end

  def new
    @purchase = Purchase.new
  end

  def create
  end

  def edit
  end

  def update
  end
end
