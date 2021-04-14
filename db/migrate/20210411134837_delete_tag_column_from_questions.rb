class DeleteTagColumnFromQuestions < ActiveRecord::Migration[6.1]
  def change
    remove_column :questions, :tag
  end
end
