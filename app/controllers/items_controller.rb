class ItemsController < ApplicationController

  def index
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
    params.require(:item).permit(:name, :text, :price, :condition, :shipping_charge, :shipping_origin, :shipping_schedule, :brand_id, :category_id, images_attributes: [:url]).merge(saler_id: current_user.id).merge(user_id: current_user.id)
  end

end