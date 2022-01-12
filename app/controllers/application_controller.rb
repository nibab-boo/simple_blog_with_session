class ApplicationController < ActionController::Base
  protect_from_forgery 
  
  private
  
  def current_user
    User.where(id: session[:user_id]).first
  end

  # def redirect_app(initial_url, exception_url)
  #   unless request.referer == initial_url
  #     redirect_to request.referer
  #   else
  #     redirect_to exception_url
  #   end
  # end

  helper_method :current_user
end
