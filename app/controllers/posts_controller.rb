class PostsController < ApplicationController
  def new
    @post = Post.new
  end

  def create
    @post = Post.new(strong_params)
    @post.user_id = helpers.current_user.id
    if @post.save!
      flash[:notice] = "post success"
      render @post
    else
      flash[:notice] = "post failed"
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

  private
  def strong_params
    params.require(:post).permit(:image, :description)
  end
end
