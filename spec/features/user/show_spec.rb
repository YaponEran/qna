require 'rails_helper'

feature 'Authenticated user tries to visit user page', %q{
  In order to get information about my account
  As an authenticated user
  I'd like to be able to visit user page
} do

  given(:user) { create(:user) }

  scenario 'Authenticated user tries to visit user page' do
    sign_in(user)

    visit user_path
    expect(page).to have_content user.email
  end

  scenario 'Unauthenticated user trie to visit user page' do
    visit user_path
    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end
end