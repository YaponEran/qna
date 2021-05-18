class Question < ApplicationRecord
  belongs_to :user

  has_many :answers, dependent: :destroy

  has_many_attached :files

  has_many :links, as: :linkable, dependent: :destroy
  accepts_nested_attributes_for :links, reject_if: :all_blank, allow_destroy: true

  validates :title, :body, presence: true
end
