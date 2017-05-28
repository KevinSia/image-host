module SessionsHelper
  def signed_in?
    !(session[:user].nil?)
  end

  def current_user
    signed_in? ? User.find(session[:user]) : nil
  end
end
