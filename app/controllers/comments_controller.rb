class CommentsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authenticate_user!
  def new
  end

  def create
    @question = Question.find(comment_params[:question_id])
    new_comment = Comment.create(comment_params)
    redirect_to question_path(@question)
  end

  def filter
    questions = Question.where(user_id: current_user).pluck(:id)
    puts(questions)
    @comments = Comment.where(:question_id => questions)
  end

  def activate
    @comment = Comment.find(params[:id])
    @comment.activate!
    redirect_to comments_filter_path
  end

  def deactivate
    @comment = Comment.find(params[:id])
    @comment.deactivate!
    redirect_to comments_filter_path
  end


  def update
  end

  def edit
  end

  def destroy

  end

  def index
  end

  def show
  end

  private def comment_params
    params.require(:comments).permit(:content, :question_id, :user_id)
  end
end
