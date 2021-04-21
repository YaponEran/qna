require 'rails_helper'

feature 'User can sign out', %q{
  In order to sign out
  As an authenticated user
  I'd like destroy session
} do

  given(:user) { create(:user) }

  scenario 'Authenticated user tries sign out' do
    sign_in(user)
    visit root_path
    click_on 'Sign out'

    expect(page).to have_content "Signed out successfully."
  end
end