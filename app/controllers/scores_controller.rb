class ScoresController < ApplicationController
  before_action :set_score, only: [:show, :edit, :update, :destroy]
  before_action :find_comment
  before_action :find_article
  before_action :logged_in?, only: [:create]


  def edit
  end



  def create
    @score = Score.new(score_params)
    @score.comment = @comment
    @score.user = current_user
    if @score.save
      redirect_to article_path(@article)
    else
      render 'scores/new'
    end
  end


  def destroy
    @score =
    @score.destroy
    redirect_to article_path(@article)
  end


  private



    def logged_in?
      current_user
    end

    def find_article
      @article = Article.find(params[:article_id])
    end

    def find_comment
      @comment= Comment.find(params[:comment_id])
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_score
      @score = Score.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def score_params
      params.require(:score).permit(:value, :comment_id)
    end

end
