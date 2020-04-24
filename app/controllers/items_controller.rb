class ItemsController < ApplicationController
  def index
  end

  def show

    @user = User.find(params[:id])

    @item = Item.find(params[:id])
    @brand = @item.brand
    @comment = Comment.new
  end

  def purchase
    Payjp.api_key = PAYJP_SECRET_KEY
    Payjp::Charge.create(currency: 'jpy', amount: 1000, card: params['payjp-token'])
    redirect_to root_path, notice: "支払いが完了しました"
  end
  
end
