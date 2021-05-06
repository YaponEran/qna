class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: %i[show index]
  before_action :set_question, only: %i[show edit update destroy]

  def index
    @questions = Question.all
  end

  def show
  end

  def new
    @question = current_user.questions.new
  end

  def create
    @question = current_user.questions.new(question_params)
    @question.user = current_user
    if @question.save
      redirect_to @question, notice: "Your question successfully created"
    else
      render :new
    end
  end

  def edit
  end

  def update
    @question.update(question_params) if current_user&.author_of?(@question)
  end

  def destroy
    @question.destroy if current_user.author_of?(@question)
    redirect_to questions_path, notice: 'Question was successfully deleted.'
  end

  private
  def set_question
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:title, :body)
  end
end
