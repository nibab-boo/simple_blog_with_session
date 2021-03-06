class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  # skip_before_action :verify_authenticity_token
  
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

  def same_user
    @user = User.find_by_user_name(params[:id])
    unless @user
      @user = Article.find(params[:id]).user
    end
    current_user == @user
  end

  def find_like(article)
    Like.where(user: current_user).where(article: article).first
  end

  helper_method :current_user, :same_user, :find_like
end
