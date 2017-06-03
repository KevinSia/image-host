class PostsController < ApplicationController
  def new
    @post = Post.new
  end

  def create
    @post = Post.new(strong_params)
    @post.user = helpers.current_user
    if @post.save!
      flash[:success] = "Image posted successfully!"
      redirect_to @post
    else
      flash[:success] = "Failed to post image."
      render :new
    end
  end

  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
    @user = @post.user
  end

  def edit
    @post = Post.find(params[:id])
    @user = @post.user
  end

  def update
    @post = Post.find(params[:id])
    @user = @post.user
    @post.description = params[:post][:description]
    if @post.save
      flash[:success] = "Updated successful!"
    else
      flash[:danger] = "Failed to update."
    end
    render :show
  end

  def destroy
    @post = Post.find(params[:id])
    @user = @post.user
    unless @user == helpers.current_user
      flash[:danger] = "Failed to delete."
      redirect_to "/posts"
    else
      @post.destroy
      flash[:success] = "Delete successful!"
      redirect_to "/posts"
    end
  end

  private
  def strong_params
    params.require(:post).permit(:image, :description)
  end
end
