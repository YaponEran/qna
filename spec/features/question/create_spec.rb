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

    scenario 'ask a question with attached files' do
      fill_in 'Title', with: 'Test question'
      fill_in 'Body', with: 'How many electrons?'

      attach_file 'File', ["#{Rails.root}/spec/rails_helper.rb", "#{Rails.root}/spec/spec_helper.rb"]
      click_on 'Ask'

      expect(page).to have_link 'rails_helper.rb'
      expect(page).to have_link 'spec_helper.rb'
    end
  end

  describe 'Multiple sessions', js: true do
    scenario 'question appears on another users page' do
      Capybara.using_session('user') do
        sign_in(user)
        visit questions_path
      end

      Capybara.using_session('guest') do
        visit questions_path
      end

      Capybara.using_session('user') do
        click_on 'Ask question'

        fill_in 'Title', with: 'Test question'
        fill_in 'Body', with: 'How many electrons?'

        click_on 'Ask'

        expect(page).to have_content 'Your question successfully created'
        expect(page).to have_content 'Test question'
        expect(page).to have_content 'How many electrons?'
      end

      Capybara.using_session('guest') do
        expect(page).to have_content 'Test question'
      end
    end
  end

  scenario 'Unauthenticated user tries ask question' do
    visit questions_path
    click_on 'Ask question'

    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end
end
