class ArticlesController < ApplicationController
  before_action :find_article, only: [:show, :edit, :update, :destroy]

  def index
    @articles = Article.all
    @articles = @articles.where("? =any(tags)", params[:q]) if params[:q].present?
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    @article.user = current_user if current_user
    if @article.save
      flash[:notice] = "You have successfuly added a new Article."
      redirect_to article_path(@article)
    else
      render 'new'
    end
  end

  def show
    @comment = Comment.new(commenter:session[:commenter])
  end

  def edit
    if @article.user != current_user
      flash[:alert] = "You are not allowed to edit this."
      redirect_to articles_path
    end
  end

  def update
    if @article.update(article_params)
      flash[:notice] = "You have successfuly updated this Article."
      redirect_to article_path(@article)
    else
      render 'edit'
    end
  end

  def destroy
    if @article.user == current_user
      @article.destroy
      flash[:alert] = "You have deleted the Article."
      redirect_to articles_path
    else
      flash[:alert] = "You are not allowed to do this."
      redirect_to articles_path
    end
  end



  private

  def article_params
    article_params = params.require(:article).permit(:title, :text, :tags)
  end

  def find_article
    @article = Article.find(params[:id])
  end

end
