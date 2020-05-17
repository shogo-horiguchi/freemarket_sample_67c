class PaymentsController < ApplicationController

  def index
    @payment = Payment.new
  end


  def new
    @payment = Payment.new
    payment = Payment.where(user_id: current_user.id)
    redirect_to action: "show" if payment.exists?
  end

  def create
    @payment = Payment.new(payment_params)
    if @payment.save
      redirect_to root_path
    else
      render :new
    end
  end

  def pay #payjpとCardのデータベース作成を実施します。
    Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
    if params['payjp-token'].blank?
      redirect_to action: "new"
    else
      customer = Payjp::Customer.create(
      description: '登録テスト', #なくてもOK
      # email: current_user.email, #なくてもOK
      card: params['payjp-token'],
      metadata: {user_id: current_user.id}
      ) #念の為metadataにuser_idを入れましたがなくてもOK
      @payment = Payment.new(user_id: current_user.id, customer_id: customer.id, card_id: customer.default_card)
      if @payment.save
        redirect_to action: "show"
      else
        redirect_to action: "pay"
      end
    end
  end

  def delete #PayjpとCardデータベースを削除します
    payment = Payment.where(user_id: current_user.id).first
    if payment.blank?
    else
      Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
      customer = Payjp::Customer.retrieve(payment.customer_id)
      customer.delete
      payment.delete
    end
      redirect_to action: "new"
  end

  def show #Cardのデータpayjpに送り情報を取り出します
    payment = Payment.where(user_id: current_user.id).first
    if payment.blank?
      redirect_to action: "new" 
    else
      Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
      customer = Payjp::Customer.retrieve(payment.customer_id)
      @default_card_information = customer.cards.retrieve(payment.card_id)
    end
  end

  def detail
  end

  private
  def payment_params
    params.require(:payment).permit(:user_id, :customer_id, :card_id).merge(user_id: current_user.id)
  end
end
