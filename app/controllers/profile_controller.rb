class ProfileController < ApplicationController  
  def get_profile
    @user_attrs = %i[first_name last_name email payment_method refund_amount]
    @bank_attrs = current_user.default_bank_account.present? ? %i[bank_name routing_number account_holder_name account_number] : nil
    @card_attrs = current_user.default_card.present? ? %i[card_type card_holder_name card_number expiration_date] : nil
  end
end
