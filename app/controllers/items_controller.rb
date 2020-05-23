class ItemsController < ApplicationController

  def index
    @brand = Brand.where('name LIKE(?)', "%#{params[:keyword]}%")
    respond_to do |format|
      format.html
      format.json
    end
  end

  def new
    @item = Item.new
    5.times do 
      @item.images.build
    end
    
    @category_parent_array = []
    Category.where(ancestry: nil).each do |parent|
      @category_parent_array << parent

    end
  end

  def get_category_children
    @category_children = Category.where(ancestry: "#{params[:parent_name]}")
  end

  def get_category_grandchildren
    @category_grandchildren = Category.find("#{params[:child_id]}").children
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

  def brand_search
    @items = Item.search(params)
    respond_to do |format|
      # format.html
      format.json
    end
  end

  private
  def item_params
    params.require(:item).permit(:name, :text, :price, :condition, :shipping_charge, :shipping_origin, :shipping_schedule, :brand_id, :category_id, images_attributes: [:url]).merge(saler_id: current_user.id).merge(user_id: current_user.id)
  end

end