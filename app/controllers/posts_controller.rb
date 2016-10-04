class PostsController < ApplicationController
  before_filter :authenticate_user!, only: [:new,:create, :edit, :update]

  def index
    @posts = Post.all.paginate(:page => params[:page], :per_page => 15)
  end

  def new 
    @post = Post.new
  end

  def create
    @post = Post.new(post_params.merge(user_id: current_user.id))
    if @post.save
      redirect_to post_path(@post.id)
    else
      flash[:danger] = @post.errors.full_messages
      redirect_to new_post_path
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update_attributes(update_params)
      redirect_to post_path(@post)
      flash[:success] = "Post updated"
    else
      redirect_to edit_post_path(@post)
      flash[:danger] = @post.errors.full_messages
    end
  end

  def show
    @post = Post.find(params[:id])
    @postcat = Post.all.where(category_id: @post.category.id)
    @find_tag = EntryTag.find_by(post_id: @post)
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :category_id, :all_tags, :photo, :bootsy_image_gallery_id)
  end

  def update_params
    params.require(:post).permit(:title, :body, :category_id, :all_tags, :photo, :bootsy_image_gallery_id)
  end

end