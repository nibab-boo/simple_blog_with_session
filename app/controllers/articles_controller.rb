class ArticlesController < ApplicationController
  # skip_before_action :login_required, :only => [:index, :show]
  before_action :find_article, only: [:show, :edit, :update, :destroy]
  before_action :find_user, only: [:new, :create, :edit, :update] # , :user_article

  def index
    @articles = Article.all
  end
  
  def show
  end

  def recent
    @articles = Article.first(:order => "id desc", :limit => 6)
  end

  def top
    redirect_to articles_path
  end

  def my
    @articles = current_user.articles
  end

  def new
    if current_user && current_user == @user
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
    unless hard_checker
      reset_session
      # raise
      flash[:notice] = 'I see what you are trying to do.Next time, I will call cops on you.Login to save yourself.'
      render 'sessions/new'
    end
  end
      
  
  def update
    if hard_checker
      @article.update(build_article)
    end
    # raise
    redirect_to article_path(@article)
  end
  
  def destroy
    user = User.find(@article[:user_id])
    @article.destroy
    redirect_to user_path(user.to_param)
  end

  private

  def build_article
    params.require(:article).permit(:title, :content)
  end

  def find_article
    @article = Article.find(params[:id])
  end

  def find_user
    @user = User.find_by_user_name(params[:user_id])
  end

  def hard_checker
    @article.user == @user && current_user == @user
  end
end
