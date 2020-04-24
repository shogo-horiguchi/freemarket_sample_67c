class ItemsController < ApplicationController
  def index
  end

  def show

    @user = User.find(params[:id])

    @item = Item.find(params[:id])
    @brand = @item.brand
    @comment = Comment.new
  end
end
