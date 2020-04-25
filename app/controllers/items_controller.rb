class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :destroy]

  def index
  end

  def show
    @user = User.find(params[:id])
    @brand = @item.brand
    @comment = Comment.new
  end

  def destroy
    if current_user == @item.user && @item.destroy 
      redirect_to root_path, method: :delete
    else
      redirect_to item_path(@item)
    end
  end

  private
  def set_item
    @item = Item.find(params[:id])
  end
end
