class SessionsController < ApplicationController
  def new
    # raise
    if current_user
      redirect_to user_path(current_user)
    end
  end

  def create
    @user = User.find_by_email(params[:user][:email]).try(:authenticate, params[:user][:password])
    if @user
      session[:user_id] = @user.id
      # redirect_to root_url, notice: 'Logged in!'
      # irequest.referer == root_url
      unless request.referer == login_url
        redirect_to request.referer
      else
        redirect_to user_path(@user.to_param)
      end
    else
      # render :new # It makes 2 request to change to GET request
      redirect_to login_path
    end
    # raise
  end

  def destroy
    reset_session
    redirect_to root_url, notice: "Logged out"
  end
end
