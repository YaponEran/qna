require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:question) { create(:question) }
  let(:answer) { create(:answer, question: question, user: user) }
  let(:user) { create(:user) }

  describe "GET #edit" do
    before { login(user) }
    before { get :edit, params: { id: answer } }

    it 'assigns requested answer tp @answer' do
      expect(assigns(:answer)).to eq answer
    end

    it 'render edit view' do
      expect(response).to render_template :edit
    end
  end

  describe 'POST #create' do
    before { login(user) }

    context 'with valid attributes' do
      it 'save a new answer to database' do
        expect { post :create, params: { answer: attributes_for(:answer), question_id: question }, format: :js }.to change(question.answers, :count).by(1)
      end

      it 'created by current user' do
        post :create, params: { answer: attributes_for(:answer), question_id: question, format: :js }
        expect(assigns(:answer).user_id).to eq subject.current_user.id
      end

      it 'renders create template' do
        post :create, params: { answer: attributes_for(:answer), question_id: question, format: :js }
        expect(response).to render_template :create
      end
    end

    context 'with invalid attributes' do
      it 'does not save the answer to database' do
        expect { post :create, params: { answer: attributes_for(:answer, :invalid), question_id: question }, format: :js }.to_not change(question.answers, :count)
      end

      it 're-renders new view' do
        post :create, params: { answer: attributes_for(:answer, :invalid), question_id: question, format: :js }
        expect(response).to render_template :create
      end
    end
  end

  describe "GET #destroy" do
    let!(:answer) { create(:answer, question: question, user: user) } 

    context 'User is author' do
      before { sign_in(user) }

      it 'author delete the answer' do
        delete :destroy, params: { id: answer }
        expect(assigns(:answer)).to be_destroyed
      end

      it 'redirects to question show' do
        delete :destroy, params: { id: answer }
        expect(response).to redirect_to question_path(question)
      end
    end

    context 'User is not author' do
      let(:other_user) { create(:user) }
      before { sign_in(other_user) }

      it 'tries to delete answer' do
        expect{ delete :destroy, params: { id: answer } }.to_not change(Answer, :count)
      end
    end

    context 'Unautehticated user' do
      it 'tries to delete answer' do 
        expect{ delete :destroy, params: { id: answer } }.to_not change(Answer, :count)
      end

      it 'redirects to login page' do
        delete :destroy, params: { id: answer }
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

end
