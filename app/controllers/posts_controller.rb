class PostsController < ApplicationController
  def new
    @post = Post.new
  end

  def create
    @post = Post.new(strong_params)
    @post.user_id = helpers.current_user.id
    if @post.save!
      flash[:notice] = "post success"
      redirect_to @post
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

  def edit
    @post = Post.find(params[:id])
    @user = @post.user
  end

  def update
    @post = Post.find(params[:id])
    @user = @post.user
    @post.description = params[:post][:description]
    if @post.save
      flash[:notice] = "Update success"
    else
      flash[:error] = "Update failed"
    end
    render :show
  end

  def destroy
    @post = Post.find(params[:id])
    @user = @post.user
    unless @user == helpers.current_user
      flash[:error] = "ERROR: Not your photo"
      redirect_to "/posts"
    else
      @post.destroy
      flash[:notice] = "delete successful."
      redirect_to "/posts"
    end
  end

  private
  def strong_params
    params.require(:post).permit(:image, :description)
  end
end
