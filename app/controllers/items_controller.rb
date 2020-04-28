class ItemsController < ApplicationController

  require 'payjp'

  def confirmation
    payment = Payment.where(user_id: current_user.id).first
    #Cardテーブルは前回記事で作成、テーブルからpayjpの顧客IDを検索
    if payment.blank?
      #登録された情報がない場合にカード登録画面に移動
      redirect_to controller: "payment", action: "new"
    else
      Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
      #保管した顧客IDでpayjpから情報取得
      customer = Payjp::Customer.retrieve(payment.customer_id)
      #保管したカードIDでpayjpから情報取得、カード情報表示のためインスタンス変数に代入
      @default_card_information = customer.cards.retrieve(payment.card_id)
    end
  end

  def show

    @user = User.find(params[:id])

    @item = Item.find(params[:id])
    @brand = @item.brand
    @comment = Comment.new
  end

  def pay
    payment = Payment.where(user_id: current_user.id).first
    Payjp.api_key = ENV['PAYJP_PRIVATE_KEY']
    Payjp::Charge.create(
    :amount => 13500, #支払金額を入力（itemテーブル等に紐づけても良い）
    :customer => payment.customer_id, #顧客ID
    :currency => 'jpy', #日本円
  )
  redirect_to action: 'done' #完了画面に移動
  end

  # def  done
  #   @product_purchaser= Item.find(params[:id])
  #   @product_purchaser.update( purchaser_id: current_user.id)
  #  end
  
end
