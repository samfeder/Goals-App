class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :signed_in?, :current_user

  def current_user
    @current_user ||= User.find_by_session_token(session[:session_token])
  end

  def signed_in?
    !!current_user
  end

  def sign_in(user)
    @current_user = user
    session[:session_token] = @current_user.reset_token!
  end

  def sign_out
    current_user.reset_token!
    session[:session_token] = nil
  end

  private

  def ensure_signed_in
    redirect_to new_session_url unless signed_in?
  end

  def ensure_signed_out
    redirect_to goals_url if signed_in?
  end
end
