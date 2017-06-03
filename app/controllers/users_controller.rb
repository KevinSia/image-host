class UsersController < ApplicationController
  skip_before_action :sign_in_first, only: [:new, :create]
  skip_before_action :check_for_username, only: [:update]

  def new
    if helpers.signed_in?
      redirect_to helpers.current_user
    else
      @user = User.new
      render layout: "homepage"
    end
  end

  def create
    @user = User.new(strong_params)
    if @user.save
      flash[:success] = "New user created successfully!"
      session[:user] = @user.id
      redirect_to "/"
    else
      flash[:danger] = @user.errors.messages
      render :new
    end
  end

  def index
    @users = User.all
    @users = @users.search_user(params[:q]) unless params[:q].nil? || params[:q].empty?
    respond_to do |format|
      format.html { }
      format.js   { }
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
    @user.replace_avatar(params[:user][:avatar])
    @user.attributes = strong_params
    if @user.save(validate: false)
      flash[:success] = "Update successful."
    else
      flash[:alert] = "Failed to update."
    end
    redirect_to "/"
  end

  private
  def strong_params
    params.require(:user).permit(:full_name, :username, :email, :password, :password_confirmation, :bio, :website, :phone, :birthday, :avatar).delete_if { |k, v| v.nil? || v == "" }
  end
end
