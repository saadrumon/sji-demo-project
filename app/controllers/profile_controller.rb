class ProfileController < ApplicationController  
  def get_profile
    @bank_account = current_user.bank_account_id? ? BankAccount.find(current_user.bank_account_id) : nil
    @card = current_user.card_id? ? Card.find(current_user.card_id) : nil
  end
end
