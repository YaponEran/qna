require 'rails_helper'

feature 'User can create answer', %q{
  In order to answer to question
  As an authenticated user
  I'd like to be able to answer on questions page
} do

  given(:user) { create(:user) }
  given(:question) { create(:question, user: user) }

  describe 'Authenticated user', js: true do
    background do 
      sign_in(user)
      visit question_path(question)
    end 

    scenario 'creates valid data anwers' do
      fill_in 'Body', with: 'Answer body'
      click_on 'Post'

      within '.answers' do
        expect(page).to have_content 'Answer body'
      end
    end

    scenario 'creates with invalid data answers' do
      click_on 'Post'
      expect(page).to have_content "Body can't be blank"
    end
  end

  scenario 'Unauthenticated user can not create answer' do
    visit questions_path(question)
    expect(page).to_not have_content 'Post'
  end

end