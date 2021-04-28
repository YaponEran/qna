require 'rails_helper'

feature 'User can delete own question', %q{
  As an authenticates user
  I'd like to able delete my questions
} do

  given(:user) { create(:user) }
  given(:other) { create(:user) }
  given(:question) { create(:question, user: user) }

  scenario 'Authentiated user tries delete own question' do
    sign_in(user)
    visit question_path(question)
    expect(page).to have_content question.title
    click_on 'Delete'

    expect(page).to_not have_content question.title
    expect(page).to have_content 'Question was successfully deleted.'
  end

  scenario 'Authenticated user tries delete some ones question' do
    sign_in(other)
    visit question_path(question)
    expect(page).to_not have_content 'Delete'
  end

  scenario 'Unauthenticated user tries to delete question' do
    visit question_path(question)
    expect(page).to_not have_content 'Delete'
  end

end