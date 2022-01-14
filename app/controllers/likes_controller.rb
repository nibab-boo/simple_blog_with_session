class LikesController < ApplicationController
  def create
    @user = current_user
  end

  def destroy
  end
end
