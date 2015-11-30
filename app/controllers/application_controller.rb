class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  #Two of the methods you declare as helpers don't exist
  helper_method :current_user, :image_url, :user_stash_count

  def current_user
    # @current_user = User.first
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

end
