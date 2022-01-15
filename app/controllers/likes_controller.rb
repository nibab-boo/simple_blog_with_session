class LikesController < ApplicationController
  def create
    if current_user
      @user = current_user
      @article = Article.find(params[:article_id])
      like = Like.create(user: @user, article: @article)
    end
    redirect_to request.referer
    # raise
  end

  def destroy
    like = Like.find(params[:id])
    if current_user == like.user
      like.destroy
    end
    redirect_to request.referer
  end
end
