class ArticlesController < ApplicationController
  # skip_before_action :login_required, :only => [:index, :show]
  before_action :find_article, only: [:show, :edit, :update, :destroy]
  before_action :find_user, only: [:new, :create] # , :user_article

  def index
    @articles = Article.all
    # raise 
  end
  
  def show
  end

  def new
    # raise
    if current_user && current_user == @user
      # @user = User.find(params[:user_id])
      @user = current_user
      @article = Article.new
    else
      # render login with email of user[params[:id]]
      render 'sessions/new', notice: 'Log in to create a article'
    end
  end
  
  def create
    article = Article.new(build_article)
    article.user = @user
    if article.save
      redirect_to articles_path
    else
      render :new
    end
  end
  
  def edit
  end
  
  
  def update
    @article.update(build_article)
    redirect_to article_path
  end
  
  def destroy
    user = User.find(@article[:user_id])
    @article.destroy
    redirect_to user_path(user)
  end

  private

  def build_article
    params.require(:article).permit(:title, :content)
  end

  def find_article
    @article = Article.find(params[:id])
  end

  def find_user
    @user = User.find(params[:user_id])
  end
end
