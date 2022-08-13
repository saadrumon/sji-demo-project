class PurchasesController < ApplicationController
  before_action :set_purchase, only: %i[edit update]

  def index
    if current_user.is_admin?
      @purchases = Purchase.all
    else
      @purchases = current_user.purchases
    end
  end

  def new
    @purchase = current_user.purchases.new
  end

  def create
    @purchase = current_user.purchases.new(purchase_params)
    @purchase.set_amount(current_user)
    if @purchase.save!
      redirect_to purchases_path,
                  notice: 'Purchase fuel successfully'
    else
      render :new
    end
  end

  def edit; end

  def update
    if @purchase.update(purchase_params)
      redirect_to purchases_path,
          notice: "Purchase was successfully updated."
    else
      render :edit
    end
  end

  private
  def set_purchase
    @purchase = Purchase.find(params[:id])
  end

  def purchase_params
    params.require(:purchase).permit(
      :unit_cost,
      :volume,
      :payment_type
    )
  end
end
