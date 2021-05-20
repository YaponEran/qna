class AddGistBodyToLink < ActiveRecord::Migration[6.1]
  def change
    add_column :links, :gist_body, :text
  end
end
