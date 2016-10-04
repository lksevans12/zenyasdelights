class CategoriesController < ApplicationController

  def index
    @categories = Category.all
  end

  def show
    @category = Category.find(params[:id])
    @posts = Post.where(category_id: @category.id).paginate(:page => params[:page], :per_page => 15)
  end

end