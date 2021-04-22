require 'rails_helper'

feature 'User can delete answer', %q{
  As an Authenticated user
  I'd like to delete my answer
} do

  given(:user) { create(:user) }
  given(:other) { create(:user) }

  scenario 'Authenticated user tries to delete own answer' do
    sign_in(user)
    question = create(:question)
    answer = create(:answer, question: question, user: user)
    visit question_path(question)
    click_on 'Delete Answer'

    expect(page).to have_content 'Answer was successfully deleted.'
  end

  scenario "Authenticated user tries to delete other's answer" do
    sign_in(other)
    question = create(:question, user: user)
    answer = create(:answer, user: user, question: question)
    visit question_path(question)

    expect(page).to_not have_content 'Delete Answer'
  end

  scenario 'Unauthenticated user tries to delete answer' do
    question = create(:question, user: user)
    answer = create(:answer, user: user, question: question)
    visit question_path(question)

    expect(page).to_not have_content 'Delete Answer'
  end
end