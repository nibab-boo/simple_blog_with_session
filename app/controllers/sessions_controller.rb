class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_email(params[:email]).try(:authenticate, params[:password])
    if user
      session[:user_id] = user.id
      session[:logged_in] = true
      redirect_to root_url, notice: 'Logged in!'      
    else
      render :new
  end
  end

  def destroy
    # session[:user_id] = nil
    # session[:logged_in] = false
    reset_session
    redirect_to root_url, notice: "Logged out"
  end
end
