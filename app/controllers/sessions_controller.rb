class SessionsController < ApplicationController
  skip_before_action :sign_in_first, only: [:new, :create, :create_from_omniauth]
  skip_before_action :check_for_username, only: [:destroy]

  def new

  end

  def create
    user = User.find_by(email: params[:email]).try(:authenticate, params[:password])
    if user
      session[:user] = user.id
      flash[:success] = "Login successful!"
      redirect_to "/"
    else
      flash[:danger] = "Invalid email or password."
      respond_to do |format|
        format.html { }
        format.js   { }
      end
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
      flash[:success] = "Logged in successfully!"
    else
      user = User.create_with_auth_and_hash(authentication, auth_hash)
      flash[:success] = "New user created successfully!"
    end
    session[:user] = user.id
    redirect_to "/"
  end
end
