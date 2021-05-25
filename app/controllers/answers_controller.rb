class AnswersController < ApplicationController
  include Voted
  
  before_action :authenticate_user!
  before_action :set_answer, only: %i[edit destroy update]
  before_action :set_question, only: :create

  def edit
  end

  def create
    @answer = @question.answers.new(answer_params)
    @answer.user = current_user
    @answer.save
  end

  def destroy
    @answer.destroy if current_user.author_of?(@answer)
  end

  def update
    if current_user&.author_of?(@answer)
      @answer.update(answer_params)
      @question = @answer.question
    end
  end

  def set_best
    @answer.set_best! if current_user&.author_of?(@answer.question)
  end

  private
  def set_answer
    @answer = Answer.with_attached_files.find(params[:id])
  end

  def set_question
    @question = Question.find(params[:question_id])
  end

  def answer_params
    params.require(:answer).permit(:body, files: [], links_attributes: [:name, :url, :_destroy])
  end
end
