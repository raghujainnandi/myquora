class QuestionsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authenticate_user!

  def import
  end

  def do_import
    puts(params)
    Question.my_import(params[:file])
    redirect_to questions_import_path , notice: "sucessfully Imported Data"
  end

  def new
  end

  def create
    @question = current_user.questions.new(questions_params)
    @question.save
    redirect_to questions_path
  end

  def update

  end

  def edit
  end

  def destroy
  end

  def index
    @questions = Question.where(aasm_state: "active")
  end

  def show
    @question = Question.find(params[:id])
  end

  def filter
    @questions = Question.where(user_id: current_user)
  end

  def activate
    @question = Question.find(params[:id])
    @question.activate!
    redirect_to questions_filter_path
  end

  def deactivate
    @question = Question.find(params[:id])
    @question.deactivate!
    redirect_to questions_filter_path
  end

  private
  def questions_params
    params.require(:questions).permit(:content)
  end
end
