class BankAccountsController < ApplicationController
  before_action :set_bank_account, only: %i[edit update]

  def new
    @bank_account = current_user.bank_accounts.new
  end

  def create
    @bank_account = current_user.bank_accounts.new(bank_account_params)
    if @bank_account.save
      if bank_account_params[:is_default].eql? "true"
        current_user.update(payment_method: User::BANK_ACCOUNT)
        current_user.default_card&.update(is_default: false)
      end
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
    params.require(:bank_account).permit( 
      :bank_name,
      :routing_number,
      :account_holder_name,
      :account_number,
      :is_default
    )
  end
end
