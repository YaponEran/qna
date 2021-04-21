class AddUserReferenceToQuestion < ActiveRecord::Migration[6.1]
  def change
    add_reference :questions, :user
  end
end
