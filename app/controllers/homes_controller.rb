class HomesController < ApplicationController
  def index
    puts "@@@"
    puts current_user.payment_method
  end
end
