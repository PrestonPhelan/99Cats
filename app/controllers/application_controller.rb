class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user, :signed_in?

  def ensure_no_user!
    redirect_to cats_url if current_user
  end

  def current_user
    @current_user ||= User.find_by_session_token(session[:session_token])
  end

  def login(user)
    session[:session_token] = user.reset_session_token!
    @current_user = user
  end

  def logout
    @current_user.reset_session_token! if @current_user
    session[:session_token] = nil
    redirect_to cats_url
  end

  def signed_in?
    !!current_user
  end
end
