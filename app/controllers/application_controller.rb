class ApplicationController < ActionController::Base
  protect_from_forgery

  def require_current_user
    redirect_to new_session_url unless current_user
  end
  
  def current_user
    @current_user ||= User.find_by_id(session[:user_id])
  end
  helper_method :current_user

  def current_user=(user)
    session[:user_id] = user && user.id
  end  
end
