class RemoveAcceptColumFromAnswer < ActiveRecord::Migration[6.1]
  def change
    remove_column :answers, :accept
  end
end
