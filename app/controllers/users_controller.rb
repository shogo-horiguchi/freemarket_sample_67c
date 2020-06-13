class UsersController < ApplicationController
  def index
    @parents = Category.all.order("id ASC").limit(13)
  end

  def show
    @user = User.find(params[:id])
    @parents = Category.all.order("id ASC").limit(13)
  end

  def logout
    @parents = Category.all.order("id ASC").limit(13)
  end
end
