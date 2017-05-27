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

  def create_from_omniauth
    auth_hash = request.env["omniauth.auth"]
    authentication = Authentication.find_by_provider_and_uid(auth_hash["provider"], auth_hash["uid"]) || Authentication.create_with_omniauth(auth_hash)
    if authentication.user
      user = authentication.user
      authentication.update_token(auth_hash)
      flash[:notice] = "Log in successfully"
    else
      user = User.create_with_auth_and_hash(authentication, auth_hash)
      flash[:notice] = "First time logging in!"
    end
    session[:user] = user.id
    redirect_to "/"
  end
end
