class SessionsController < ApplicationController
  def new
    if current_user
      redirect_to user_path(current_user)
    end
  end

  def create
    user = User.find_by_email(params[:user][:email]).try(:authenticate, params[:user][:password])
    if user
      session[:user_id] = user.id
      # redirect_to root_url, notice: 'Logged in!'
      # irequest.referer == root_url
      redirect_app(login_url, user_path(user))
      # raise
    else
      render :new
    end
  end

  def destroy
    reset_session
    redirect_to root_url, notice: "Logged out"
  end
end
