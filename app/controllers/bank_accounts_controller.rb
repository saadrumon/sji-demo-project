class BankAccountsController < ApplicationController
  # before_action :set_bank_account, only: %i[new edit create update]
  def new
    @bank_account = BankAccount.new
  end

  def create
    @bank_account = BankAccount.new(bank_account_params)
    if @bank_account.save
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

  # def set_bank_account
  #   begin
  #     @bank_account = BankAccount.find(params[:bank_account_id])
  #   rescue StandardError => e
  #     redirect_to fallback_location: root_path,
  #                 flash: { error: "Error occurred while fetching bank account" }
  #   end
  # end
  def bank_account_params
    params.require(:bank_account).permit(:bank_account_id,
                                           :bank_name,
                                           :routing_number,
                                           :account_holder_name,
                                           :account_number)
  end
end
