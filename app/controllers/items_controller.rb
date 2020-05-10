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
  
  def index
    @items = Item.limit(3).order(id: "DESC")
    @brands = Item.where(brand_id:"1").last(3).sort.reverse
  end

  def new
    @category_parent_array = ["___"]
    Category.where(ancestry: nil).each do |parent|
    @category_parent_array << parent.name
    end
  end


  def get_category_children
      @category_children = Category.find_by(name: "#{params[:parent_name]}", ancestry: nil).children
  end

  def get_category_grandchildren
      @category_grandchildren = Category.find("#{params[:child_id]}").children
  end

  def show
    @user = User.find(params[:id])
    @brand = @item.brand
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

  private

  def set_item
    @item = Item.find(params[:id])
    @parent_category_items = nil
    @child_category_items = Item.where(child_category_id: @children_category.id)
    @grand_category_items = Item.where(grand_child_category_id: @grand_category.id)
  end

  def new
    @item = Item.new
    10.times do 
      @item.images.build
    end
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path, notice: '商品が出品されました'
    else
      # @item = Item.create.includes(:user)
      flash.now[:alert] = '必須項目が抜けています'
      render new_item_path
    end
    
  end

  private
  def item_params
    params.require(:item).permit(:name, :text, :price, :condition, :shipping_charge, :shipping_origin, :shipping_schedule, :brand_id, :category_id, images_attributes: [:url]).merge(user_id: current_user.id)
  end
end
