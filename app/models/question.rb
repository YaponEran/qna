class Question < ApplicationRecord

  TAG_NAME = %w[art history sport code game]

  has_many :answers, dependent: :destroy

  validates :title, :body, :tag, presence: true
  validates :tag, inclusion: { in: TAG_NAME }
end
