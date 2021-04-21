require 'rails_helper'

feature 'User can create question', %q{
  In order to get answer form comunnity
  As an Authenticated user
  I'd like to be able to ask the question
} do
  given(:user) { create(:user) }

  describe 'Authenticated user' do
    background do 
      sign_in(user)
      visit questions_path
      click_on 'Ask question'
    end

    scenario 'ask a question' do
      fill_in 'Title', with: 'Test question'
      fill_in 'Body', with: 'How many electrons?'
      click_on 'Ask'

      expect(page).to have_content 'Your question successfully created'
      expect(page).to have_content 'Test question'
      expect(page).to have_content 'How many electrons?'
    end
    
    scenario 'ask a question with error' do
      click_on 'Ask'

      expect(page).to have_content "Title can't be blank"
    end
  end

end