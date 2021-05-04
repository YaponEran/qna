class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_answer, only: %i[edit destroy]
  before_action :set_question, only: :create

  def edit
  end

  def create
    @answer = @question.answers.new(answer_params)
    @answer.user = current_user
    
    if @answer.save
      redirect_to @question, notice: 'Your answer successfully created.'
    else
        render 'questions/show'
    end
  end

  def destroy
    @answer.destroy if current_user.author_of?(@answer)
    redirect_to question_path(@answer.question), notice: 'Your answer successfully deleted.'
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
