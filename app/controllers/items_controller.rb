class ItemsController < ApplicationController
  before_action :set_item, only: [:edit, :show, :update, :destroy]
  before_action :set_category, only: [:new, :create, :edit, :update]
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
    if Brand.nil?
    else
      @brands = Item.where(brand_id:"1").last(3).sort.reverse
    end
    if Category.nil?
    else
      @parents = Category.all.order("id ASC").limit(13)
    end
  end

  def index_recent_posted
    @items = Item.where(buyer_id: nil).order(id: "DESC")
  end

  def index_selling
    @items = Item.where(buyer_id: nil).where(user_id: current_user.id).order(id: "DESC")
  end

  def index_sold
    @items = Item.where(buyer_id: present?).where(user_id: current_user.id).order(id: "DESC")
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

  def new
    @item = Item.new
    5.times do
      @item.images.build
    end
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to item_path(@item), notice: '商品が出品されました'
    else
      num = @item.images.length
      (5 - num).times do
        @item.images.build
      end
      @grand_children_categories = @item.category.siblings if @item.category.present?
      @children_categories = @item.category.parent.siblings if @item.category.present?
      flash.now[:alert] = '必須項目が抜けています'
      render :new
    end
  end

  def show
    @brand = @item.brand
    @comment = Comment.new
    if Category.nil?
    else
      @parents = Category.all.order("id ASC").limit(13)
    end
  end

  def edit
    @item.images.cache_key unless @item.images.blank?
  end

  def update
    if @item.update(item_params)
      redirect_to item_path(@item), notice: '商品が編集されました'
    else
      flash.now[:alert] = '必須項目が抜けています'
      render new_item_path
    end
  end

  def destroy
    if current_user == @item.user && @item.destroy
      redirect_to root_path, method: :delete
    else
      redirect_to item_path(@item)
    end
  end

  def brand_search
    @items = Item.search(params)
    respond_to do |format|
      # format.html
      format.json
    end
  end

  def set_category
    @category_parent_array = Category.where(ancestry: nil).inject([]) { |category_parent_array,(name)| category_parent_array << name}
  end

  def get_category_children
    @category_children = Category.where(ancestry: "#{params[:parent_name]}")
  end

  def get_category_grandchildren
    @category_grandchildren = Category.find("#{params[:child_id]}").children
  end

  private
  def set_item
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:name, :text, :price, :condition, :shipping_charge, :shipping_origin, :shipping_schedule, :brand_id, :category_id, :size, images_attributes: [:url]).merge(saler_id: current_user.id).merge(user_id: current_user.id)
  end
end
