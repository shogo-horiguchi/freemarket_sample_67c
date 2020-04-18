class ItemsController < ApplicationController
  def index
  end

  def show
    @item = Item.find(params[:id])
    @brand = @item.brand
    @comment = Comment.new
  end
end
