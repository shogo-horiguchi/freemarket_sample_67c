class PaymentsController < ApplicationController
  def new
    @payment = Payment.new
  end

  def create
    Payment.create(payment_params)
    redirect_to root_path
  end

  private
  def payment_params
    params.require(:payment).permit(:card_number, :expireation_year, :expireation_month, :security_key).merge(user_id: current_user.id)
  end
end
