class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(strong_params)
    if @user.save
      flash[:notice] = "Account creation success!"
      render :new
    else
      flash[:error] = @user.errors.messages
      render :new
    end
  end

  def index
    @users = User.all
  end

  private
  def strong_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
