class UsersController < ApplicationController
  skip_before_action :check_for_username, only: [:update]

  def new
    @user = User.new
  end

  def create
    @user = User.new(strong_params)
    if @user.save
      flash[:notice] = "Account creation success!"
      redirect_to "/sign_in"
    else
      flash[:error] = @user.errors.messages
      render :new
    end
  end

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = helpers.current_user
  end

  def update
    @user = helpers.current_user
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
    params.require(:user).permit(:full_name, :username, :email, :password, :password_confirmation, :bio, :website, :phone, :birthday).delete_if { |k, v| v.empty? }
  end
end
