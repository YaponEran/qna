require 'rails_helper'

feature "User can add links to question", %q{
  In order to provide additional info to my question
  As an question's author
  I'd like to be able to add links
} do

  given(:user) { create(:user) }
  given(:question) { create(:question) }
  given(:url) { 'https://github.com' }
  given(:url2) { 'https://aif-fairs.com' }

  describe 'User ask question' js: true do
    before do
      sign_in(user)
      visit new_question_path
    end

    scenario 'with valid URL-link' do
      fill_in 'Title', with: 'Test question'
      fill_in 'Body', with: 'cat cat cat'

      fill_in 'Link name', with: 'Some link'
      fill_in 'Url', with: url

      click_on 'Ask'

      expect(page).to have_link 'SomeLink', href: url
    end

    scenario 'with invalid URL-link' do
      fill_in 'Title', with: 'Test question'
      fill_in 'Body', with: 'cat cat cat'

      fill_in 'Link name', with: 'Some link'
      fill_in 'Url', with: 'invalid url'

      click_on 'Ask'

      expect(page).to have_content 'Links url must be a valid URL'
      expect(page).to_not have_content 'SomeLink'
      expect(page).to_not have_content 'just URL'
    end

    scenario 'with multiple links' do
      fill_in 'Title', with: 'Test question'
      fill_in 'Body', with: 'cat cat cat'

      fill_in 'Link name', with: 'Some link'
      fill_in 'Url', with: url

      click_on 'add link'

      page.all('.nested-fields').last.fill_in 'Link name', with: 'SomeSecondLink'
      page.all('.nested-fields').last.fill_in 'Url', with: url2

      click_on 'Ask'

      expect(page).to have_link 'SomeLink', href: url
      expect(page).to have_link 'SomeSecondLink', href: url2
    end
  end

end