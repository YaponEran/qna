require 'rails_helper'

RSpec.describe Question, type: :model do
  it { should validate_presence_of :title }
  it { should validate_presence_of :body }
  it { should validate_presence_of :tag }

  it { should have_many(:answers) }

  it { should validate_inclusion_of(:tag).
       in_array(['art', 'history', 'sport', 'code', 'game'])
     }
end
