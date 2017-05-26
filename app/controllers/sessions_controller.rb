class SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:email]).try(:authenticate, params[:password])
    if user
      session[:user] = user.id
      flash[:notice] = "Login successful"
      redirect_to "/"
    else
      flash[:error] = "Invalid email or password"
      render :new
    end
  end

  def destroy
    session.delete(:user)
    redirect_to "/"
  end
end
