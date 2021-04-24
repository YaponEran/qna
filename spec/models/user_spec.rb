require 'rails_helper'

RSpec.describe User, type: :model do
  it { should validate_presence_of :email }
  it { should validate_presence_of :password }

  it { should have_many(:questions).dependent(:destroy) }
  it { should have_many(:answers).dependent(:destroy) }

  describe 'Checl authorship' do
    let(:user) { create(:user) }

    it 'current user is author' do
      question = create(:question, user: user) 
      expect(user).to be_author_of(question)
    end

    it 'current user is not author' do
      question = create(:question)
      expect(user).to_not be_author_of(question)
    end
  end
end
