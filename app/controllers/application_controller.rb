class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :sign_in_first
  before_action :check_for_username

  private
  def sign_in_first
    unless helpers.signed_in?
      redirect_to "/"
    end
  end

  def check_for_username
    if helpers.signed_in? && helpers.current_user.username.nil?
      render "/users/initial_setup", locals: {user: helpers.current_user}
    end
  end
end
