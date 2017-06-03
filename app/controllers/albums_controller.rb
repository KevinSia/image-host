class AlbumsController < ApplicationController
  before_action :find_album, only: [:show, :edit, :update, :destroy]
  before_action :convert_id_array_to_posts, only: [:create, :update]

  def new
    @album = Album.new
  end

  def create
    @album = Album.new(strong_params)
    @album.posts = @selected_posts || []
    @album.user = helpers.current_user

    if @album.save
      flash[:success] = "Album created successfully!"
      redirect_to @album
    else
      flash[:danger] = "Failed to create new album."
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
    @album.posts = @selected_posts || []

    if @album.save
      flash[:success] = "Album updated successfully!"
      redirect_to @album
    else
      flash[:danger] = "Failed to update album."
      render :new
    end
  end

  def destroy
    if @album.destroy
      flash[:success] = "Album deleted successfully!"
      redirect_to "/"
    else
      flash[:danger] = "Album failed to delete."
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
    return nil if @selected_posts.nil?
    @selected_posts.map! do |x|
      Post.find(x)
    end
  end

  def strong_params
    params.require(:album).permit(:title, :description)
  end
end
