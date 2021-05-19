require 'rails_helper'

feature 'User can add links to answer', %q{
  In order to provide additional info to my answer
  As an answer's author
  I'd like to be able to add links
} do

  given(:user) { create(:user) }
  given!(:question) { create(:question, user: user) }
  given(:url) { 'https://github.com' }
  given(:url2) { 'https://aif-fairs.com' }


  describe 'User gives an answer', js: true do
    before do
      sign_in(user)
      visit question_path(question)
    end

    scenario 'with valid URL-link' do
      fill_in 'Body', with: 'My answer'

      fill_in 'Link name', with: 'SomeLink'
      fill_in 'Url', with: url

      click_on 'Create'

      within '.answers' do
        expect(page).to have_link 'SomeLink', href: url
      end
    end

    scenario 'with invalid URL-link' do
      fill_in 'Body', with: 'My answer'

      fill_in 'Link name', with: 'SomeLink'
      fill_in 'Url', with: 'just URL'

      click_on 'Create'

      expect(page).to have_content 'Links url must be a valid URL'
      expect(page).to_not have_content 'SomeLink'
      expect(page).to_not have_content 'just URL'
    end

    scenario 'with multiple links' do
      fill_in 'Body', with: 'My answer'

      fill_in 'Link name', with: 'SomeLink'
      fill_in 'Url', with: url

      click_on 'add link'

      page.all('.nested-fields').last.fill_in 'Link name', with: 'SomeSecondLink'
      page.all('.nested-fields').last.fill_in 'Url', with: url2

      click_on 'Create'

      within '.answers' do
        expect(page).to have_link 'SomeLink', href: url
        expect(page).to have_link 'SomeSecondLink', href: url2
      end
    end

  end
end
