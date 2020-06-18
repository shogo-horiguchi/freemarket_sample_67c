module CommonActions

  extend ActiveSupport::Concern

  def set_categories
    @categories = Category.where(params[:id])
    @category_children1 = Category.where(category_id: 1)
    @category_children2 = Category.where(category_id: 2)
    @category_children3 = Category.where(category_id: 3)
    @category_children4 = Category.where(category_id: 4)
    @category_children5 = Category.where(category_id: 5)
    @category_children6 = Category.where(category_id: 6)
    @category_children7 = Category.where(category_id: 7)
    @category_children8 = Category.where(category_id: 8)
    @category_children9 = Category.where(category_id: 9)
    @category_children10 = Category.where(category_id: 10)
    @category_children11 = Category.where(category_id: 11)
    @category_children12 = Category.where(category_id: 12)
    @category_children13 = Category.where(category_id: 13)
  end

end
