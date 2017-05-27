module SessionsHelper
  def signed_in?
    !(session[:user].nil?)
  end

  def current_user
    User.find(session[:user])
  end
end
