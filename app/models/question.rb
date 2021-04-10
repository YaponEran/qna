class Question < ApplicationRecord

  validates :title, presence: true
  validates :body, presence: true
  validates :tag, presence: true

end
