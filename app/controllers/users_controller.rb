class UsersController < ApplicationController
  skip_before_action :sign_in_first, only: [:new, :create]
  skip_before_action :check_for_username, only: [:update]

  def new
    if helpers.signed_in?
      redirect_to helpers.current_user
    else
      @user = User.new
      render layout: false
    end
  end

  def create
    @user = User.new(strong_params)
    if @user.save
      flash[:notice] = "Account creation success!"
      session[:user] = @user.id
      redirect_to "/"
    else
      flash[:error] = @user.errors.messages
      render :new
    end
  end

  def index
    @users = User.all
    @users = @users.search_user(params[:q]) unless params[:q].nil?
    respond_to do |format|
      format.html { }
      format.js   { render layout: false }
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
    redirect_to "/" if @user != helpers.current_user
  end

  def update
    @user = helpers.current_user
    new_avatar = params[:user][:avatar]
    if new_avatar
      @user.avatar = new_avatar
      # TODO for some reason I can't overwite the existing image directly so I have to delete the old one like this
      # how do I do it directly?
      if @user.valid?
        @user.remove_avatar!
        @user.save
      end
    end
    @user.attributes = strong_params
    if @user.save(validate: false)
      flash[:notice] = "update success"
    else
      flash[:alert] = "update failed"
    end
    redirect_to "/"
  end

  private
  def strong_params
    params.require(:user).permit(:full_name, :username, :email, :password, :password_confirmation, :bio, :website, :phone, :birthday, :avatar).delete_if { |k, v| v.nil? || v == "" }
  end
end
