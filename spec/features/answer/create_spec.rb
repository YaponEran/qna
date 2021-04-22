require 'rails_helper'

feature 'User can create answer', %q{
  In order to answer to question
  As an authenticated user
  I'd like to be able to answer on questions page
} do

  given(:user) { create(:user) }

  describe 'Authenticated user' do
    given(:question) { create(:question) }
    
    background do 
      sign_in(user)
      visit question_path(question)
    end 

    scenario 'creates valid question' do
      fill_in 'Body', with: 'Answer body'
      click_on 'Post'

      expect(page).to have_content 'Your answer successfully created.'
      expect(page).to have_content 'Answer body'
    end

    scenario 'create invalid questions' do
      click_on 'Post'
      expect(page).to have_content "Body can't be blank."
    end
  end

end