class RemoveNullFromAnswerQuestionId < ActiveRecord::Migration[6.1]
  def change
    change_column_null :answers, :question_id, true
  end
end
