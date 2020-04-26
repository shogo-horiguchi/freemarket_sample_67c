class ItemsController < ApplicationController

  def index
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

  private
  def set_item
    @item = Item.find(params[:id])
    @parent_category_items = nil
    @child_category_items = Item.where(child_category_id: @children_category.id)
    @grand_category_items = Item.where(grand_child_category_id: @grand_category.id)
end
