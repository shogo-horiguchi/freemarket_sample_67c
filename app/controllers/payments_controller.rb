class PaymentsController < ApplicationController
  def new
    @payment = Payment.new
  end

  def create
    @payment = Payment.new(payment_params)
    if @payment.save
      redirect_to root_path
    else
      render :new
    end
  end

  private
  def payment_params
    params.require(:payment).permit(:card_number, :expireation_year, :expireation_month, :security_key).merge(user_id: current_user.id)
  end
end
