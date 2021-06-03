require 'rails_helper'

RSpec.describe User, type: :model do
  it { should validate_presence_of :email }
  it { should validate_presence_of :password }

  it { should have_many(:questions).dependent(:destroy) }
  it { should have_many(:answers).dependent(:destroy) }
  it { should have_many(:authorizations).dependent(:destroy) }

  describe '#author_of?' do
    let(:user) { create(:user) }
    let(:author_question) { create(:question, user: user) }
    let(:question) { create(:question) }

    it 'current user is author' do
      expect(user).to be_author_of(author_question)
    end

    it 'current user is not author' do
      expect(user).to_not be_author_of(question)
    end
  end
end
