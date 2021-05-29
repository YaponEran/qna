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

    scenario 'answers the question with attached files' do
      fill_in 'Body', with: 'Answer body'

      attach_file 'File', ["#{Rails.root}/spec/rails_helper.rb", "#{Rails.root}/spec/spec_helper.rb"]
      click_on 'Post'

      expect(page).to have_link 'rails_helper.rb'
      expect(page).to have_link 'spec_helper.rb'
    end
  end

  describe 'Multiple sessions', js: true do
    scenario 'answer appears on another users page' do
      Capybara.using_session('user') do
        sign_in(user)
        visit question_path(question)
      end

      Capybara.using_session('guest') do
        visit question_path(question)
      end

      Capybara.using_session('user') do
        fill_in 'Body', with: 'My answer'

        fill_in 'Link name', with: 'SomeLink'
        fill_in 'Url', with: url

        click_on 'Create'

        within '.answers' do
          expect(page).to have_content 'My answer'
          expect(page).to have_link 'SomeLink', href: url
        end
      end

      Capybara.using_session('guest') do
        within '.answers' do
          expect(page).to have_content 'My answer'
          expect(page).to have_link 'SomeLink', href: url
        end
      end
    end
  end

  scenario 'Unauthenticated user can not create answer' do
    visit questions_path(question)
    expect(page).to_not have_content 'Post'
  end
end
