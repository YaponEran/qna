class Answer < ApplicationRecord
  include Votable
  
  belongs_to :question
  belongs_to :user

  has_many_attached :files

  has_many :links, as: :linkable, dependent: :destroy
  accepts_nested_attributes_for :links, reject_if: :all_blank, allow_destroy: true
  
  validates :body, presence: true

  def set_best!
    transaction do
      question.answers.lock!.update_all(best: false)
      update!(best: true)
    end
  end

end
