require 'rails_helper'

feature 'User can see all questions', %q{
  In order to find Answer
  As any user
  I'd like to able to see all questions
} do
  
  scenario 'User tries to visit questions index page' do
    visit questions_path
    expect(page).to have_content "All Questions (#{Question.count} found):"
  end
end