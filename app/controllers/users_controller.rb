class UsersController < ApplicationController
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

  private
  def strong_params
    params.require(:user).permit(:full_name, :email, :password, :password_confirmation)
  end
end
