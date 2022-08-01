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
    @purchase = Purchase.new
  end

  def create
    @purchase = Purchase.new(purchase_params)
    @current_user = current_user
    @purchase.amount = params[:purchase][:volume].to_f * ENV["FUEL_COST_PER_VOLUME"].to_f
    @purchase.user_id = @current_user.id
    if params[:purchase][:payment_type].eql?('Pay_now')
      @purchase.status = Purchase::PENDING
    else
      @purchase.status = Purchase::UNPAID
    end
    if @purchase.save
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
