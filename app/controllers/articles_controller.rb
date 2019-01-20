class ArticlesController < ApplicationController
  before_action :find_article, only: [:show, :edit, :update, :destroy, :toggle_visibility]
  before_action :authenticate_user!, except: [:show, :index]
  before_action :authorize_user, only: [:destroy, :edit, :update]

  def index
    if current_user&.admin?
      @articles = Article.all
    else
      @articles = Article.published
    end
    @most_commented = @articles.most_commented
    @articles = @articles.includes(:user).order(id: :desc)
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
    @comment = Comment.new
    @like = Like.find_or_initialize_by(article: @article, user: current_user)

    respond_to do |format|
      format.html do
        @article.increment!(:views_count)
        render
      end

      format.json do
        sleep(rand(100)/10)
        render json: {
          id: @article.id,
          title: @article.title,
          text: @article.text,
          views_count: @article.views_count,
          likes_count: @article.likes_count,
          comments_count: @article.comments_count
        }
      end
    end

  end

  def edit
  end

  def update
    if @article.update(article_params) || current_user&.admin?
      flash[:notice] = "You have successfuly updated this Article."
      redirect_to article_path(@article)
    else
      render 'edit'
    end
  end

  def destroy
    @article.destroy
    flash[:alert] = "You have deleted the Article."
    redirect_to articles_path
  end

  def toggle_visibility
    return redirect_to articles_path, error: 'Not found' unless current_user&.admin?
    @article.toggle!(:published)
    redirect_to articles_path, notice: "Your article visibility has been changed"
  end


  private

  def authorize_user
    if @article.user != current_user && !current_user&.admin?
      flash[:alert] = "You are not allowed to do this."
      redirect_to articles_path
      return false
    end
  true
  end

  def article_params
    article_params = params.require(:article).permit(:title, :text, :tags)
  end

  def find_article
    @article = if current_user&.admin?
                Article.find(params[:id])
              else
                Article.published.find(params[:id])
              end
  end

end
