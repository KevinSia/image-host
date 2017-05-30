class AlbumsController < ApplicationController
  def new
    @album = Album.new
  end

  def create
    @album = Album.new(strong_params)
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
    @album = Album.find(params[:id])
  end

  def edit
    @album = Album.find(params[:id])
  end

  def update
    @album = Album.find(params[:id])
    @album.update_attributes(strong_params)
    if @album.save
      flash[:notice] = "album create successfully"
      redirect_to @album
    else
      flash[:error] = "album create failed"
      render :new
    end
  end

  def destroy
    @album = Album.find(params[:id])
    if @album.destroy
      flash[:notice] = "album destroyed successfully"
      redirect_to "/"
    else
      flash[:error] = "album destroyed failed"
      redirect_to @album
    end
  end

  private
  def strong_params
    params.require(:album).permit(:title, :description)
  end
end
