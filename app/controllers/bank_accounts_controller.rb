class BankAccountsController < ApplicationController
  def new
    @bank_account = BankAccount.new
  end

  def create
    @bank_account = BankAccount.new(bank_account_params)
    @current_user = current_user
    if @bank_account.save
      @current_user.bank_account_id = @bank_account.id
      @current_user.save
      redirect_to root_path,
                  notice: 'Bank account save successfully'
    else
      render :new
    end
  end

  def edit
  end

  def update
  end
  
  private
  def bank_account_params
    params.require(:bank_account).permit(:bank_account_id,
                                           :bank_name,
                                           :routing_number,
                                           :account_holder_name,
                                           :account_number)
  end
end
