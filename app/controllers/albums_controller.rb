class AlbumsController < ApplicationController
  before_action :find_album, only: [:show, :edit, :update, :destroy]
  before_action :convert_id_array_to_posts, only: [:create, :update]

  def new
    @album = Album.new
  end

  def create
    @album = Album.new(strong_params)
    @album.posts = @selected_posts
    @album.user = helpers.current_user

    if @album.save
      flash[:notice] = "album create successfully"
      redirect_to @album
    else
      flash[:error] = "album create failed"
      render :new
    end
  end

  def index
    @albums = Album.all
  end

  def show

  end

  def edit

  end

  def update
    @album.update_attributes(strong_params)
    @album.posts = @selected_posts

    if @album.save
      flash[:notice] = "album create successfully"
      redirect_to @album
    else
      flash[:error] = "album create failed"
      render :new
    end
  end

  def destroy
    if @album.destroy
      flash[:notice] = "album destroyed successfully"
      redirect_to "/"
    else
      flash[:error] = "album destroyed failed"
      redirect_to @album
    end
  end

  private
  def find_album
    @album = Album.find(params[:id])
  end

  def convert_id_array_to_posts
    # convert the array of ids to models
    @selected_posts = params[:album][:posts]
    @selected_posts.map! do |x|
    # TODO check if users can still inject another user's id into the selected_posts array?
    # if so fix!
      Post.find(x)
    end
  end

  def strong_params
    params.require(:album).permit(:title, :description, posts: [])
  end
end
