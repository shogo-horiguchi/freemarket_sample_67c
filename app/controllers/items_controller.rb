class ItemsController < ApplicationController

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