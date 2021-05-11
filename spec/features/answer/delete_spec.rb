require 'rails_helper'

feature 'User can delete answer', %q{
  As an Authenticated user
  I'd like to delete my answer
} do

  given(:user) { create(:user) }
  given(:other) { create(:user) }
  given!(:question) { create(:question) }
  given!(:answer) { create(:answer) }

  describe 'Authenticated user' do
    background { visit question_path(answer.question) }
    
    scenario 'tries to delete own answer', js: true do
      sign_in(answer.user)
      expect(page).to have_content answer.body
      click_on 'Delete Answer'
  
      expect(page).to_not have_content answer.body
    end
  
    scenario "tries to delete other's answer", js: true do
      sign_in(other)
      expect(page).to_not have_content 'Delete Answer'
    end
  end

  scenario 'Unauthenticated user tries to delete answer' do
    visit question_path(answer.question)
    expect(page).to_not have_content 'Delete Answer'
  end
end