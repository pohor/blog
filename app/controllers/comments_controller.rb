class CommentsController < ApplicationController
  before_action :find_article

  def create
    @comment = Comment.new(comment_params)
    @comment.article = @article
    if @comment.save
      session[:commenter] = @comment.commenter
      redirect_to article_path(@article)
    else
      render 'articles/show'
    end
  end

  def edit
    find_comment
  end

  def update
    find_comment
    if @comment.update(comment_params)
      redirect_to article_path(@article)
    else
      render 'edit'
    end
  end

  def destroy
    find_comment
    @comment.destroy
    redirect_to article_path(@article)
  end

  private

  def find_comment
    @comment = Comment.find(params[:id])
  end

  def find_article
    @article = Article.find(params[:article_id])
  end


  def comment_params
    comment_params = params.require(:comment).permit(:commenter, :body)
  end

end
