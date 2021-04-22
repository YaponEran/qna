class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_answer, only: %i[show edit destroy]
  before_action :set_question, only: %i[new create]

  def show
  end

  def new
    @answer = @question.answers.new
  end

  def edit
  end

  def create
    @answer = @question.answers.new(answer_params)
    @answer.user = current_user
    
    if @answer.save
      redirect_to @question, notice: 'Your answer successfully created.'
    else
      redirect_to @question, notice: "Body can't be blank."
    end
  end

  def destroy
    @answer.destroy
    redirect_to questions_path, notice: 'Answer was successfully deleted.'
  end

  private
  def set_answer
    @answer = Answer.find(params[:id])
  end

  def set_question
    @question = Question.find(params[:question_id])
  end

  def answer_params
    params.require(:answer).permit(:body)
  end
end
