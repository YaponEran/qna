class RemovePointColumFromAnswer < ActiveRecord::Migration[6.1]
  def change
    remove_column :answers, :point
  end
end
