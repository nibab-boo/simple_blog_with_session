class LikesController < ApplicationController
  def create
    @user = current_user
    @article = Article.find(params[:article_id])
    Like.create(user: @user, article: @article)
    redirect_to request.referer
    # raise
  end

  def destroy
  end
end
