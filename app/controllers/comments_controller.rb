class CommentsController < ApplicationController
  before_action :find_article
  before_action :find_comment, only: [:destroy, :update, :edit]
  before_action :logged_in?, only: [:create]
  before_action :authenticate_user, only: [:destroy, :edit, :update]

  def create
    @comment = Comment.new(comment_params)
    @comment.article = @article
    @like = Like.find_or_initialize_by(article: @article, user: current_user)
    @comment.user = current_user
    if @comment.save
      # session[:commenter] = @comment.user
      flash[:notice] = "You have successfuly added a comment."
      redirect_to article_path(@article)
    else
      render 'articles/show'
    end
  end


  def edit
  end

  def update
    if @comment.update(comment_params)
      flash[:notice] = "You have successfuly updated the comment."
      redirect_to article_path(@article)
    else
      render 'edit'
    end
  end

  def destroy
    @comment.destroy
    flash[:notice] = "You have deleted the comment."
    redirect_to article_path(@article)
  end

  private

  def authenticate_user
    if @comment.user != current_user && !current_user&.admin?
      flash[:alert] = "You are not allowed to do this."
      redirect_to article_path(@article)
      return false
    end
  true
  end

  def logged_in?
    current_user
  end

  def find_comment
    @comment = Comment.find(params[:id])
  end

  def find_article
    @article = Article.find(params[:article_id])
  end


  def comment_params
    comment_params = params.require(:comment).permit(:body)
  end

end
