require 'rails_helper'

feature 'User can see all questions', %q{
  In order to find Answer
  As any user
  I'd like to able to see all questions
} do

  given(:user) { create(:user) }
  given!(:questions) { create_list(:question, 3, user: user) }
  
  scenario 'sees all of questions' do
    visit questions_path
    questions.each { |question| expect(page).to have_content(question.title) }
  end
end