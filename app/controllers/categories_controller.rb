class CategoriesController < ApplicationController
  def index
    @parents = Category.all.order("id ASC").limit(13)
  end

  def new
    @children = Category.find(params[:parent_id]).children
    respond_to do |format|
      format.html
      format.json
    end
  end

  def show
    @category = Category.find_by(id: params[:id])
    @items = @category.items
    @user = User.find(params[:id])
    # @brand = @item.brand
  end
  
  private

  def set_item
    @item = Item.find(params[:id])
    @parent_category_items = nil
    @child_category_items = Item.where(child_category_id: @children_category.id)
    @grand_category_items = Item.where(grand_child_category_id: @grand_category.id)
  end
end
