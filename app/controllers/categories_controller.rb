class CategoriesController < ApplicationController

  def show
    @category = Category.find_by(id: params[:id])
    @items = @category.items
    # @user = User.find(params[:id])
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
