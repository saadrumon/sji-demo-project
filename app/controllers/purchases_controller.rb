class PurchasesController < ApplicationController
  before_action :set_purchase, only: %i[edit update]
  def index
    if current_user.is_admin
      @purchases = Purchase.all
    else
      @purchases = Purchase.where(user_id: current_user.id)
    end
  end

  def new
    @purchase = current_user.purchases.new
  end

  def create
    @purchase = current_user.purchases.new(purchase_params)
    if @purchase.save!
      redirect_to purchases_path,
                  notice: 'Purchase fuel successfully'
    else
      render :new
    end
  end

  def edit
  end

  def update
    @purchase.adjust_amount(params[:purchase][:adjustment_amount].to_f)
    redirect_to purchases_path,
                notice: 'Adjustment successfully'
  end

  private
  def set_purchase
    @purchase = Purchase.find(params[:id])
  end
  def purchase_params
    params.require(:purchase).permit(
                                 :volume,
                                 :payment_type,
                                 :adjustment_amount)
  end
end
