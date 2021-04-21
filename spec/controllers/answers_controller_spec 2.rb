require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:question) { create(:question) }
  let(:answer) { create(:answer) }

  describe 'GET #show' do
    before { get :show, params: { id: answer }}

    it 'assigns the requested answer to @answer' do
      expect(assigns(:answer)).to eq answer
    end 

    it 'render show view' do
      expect(response).to render_template :show
    end
  end

  describe "GET #new" do
    before { get :new, params: { question_id: question } }

    it 'assigns a new Answer to @asnwers' do
      expect(assigns(:answer)).to be_a_new(Answer)
    end

    it 'renders new view' do
      expect(response).to render_template :new
    end
  end

  describe "GET #edit" do
    before { get :edit, params: { id: answer } }

    it 'assigns requested answer tp @answer' do
      expect(assigns(:answer)).to eq answer
    end

    it 'render edit view' do
      expect(response).to render_template :edit
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'save a new answer to database' do
        expect { post :create, params: { answer: attributes_for(:answer), question_id: question } }.to change(question.answers, :count).by(1)
      end

      it 'redirects to question show view' do
        post :create, params: { answer: attributes_for(:answer), question_id: question }
        expect(response).to redirect_to assigns(:question)
      end
    end

    context 'with invalid attributes' do
      it 'does not save the answer to database' do
        expect { post :create, params: { answer: attributes_for(:answer, :invalid), question_id: question } }.to_not change(question.answers, :count)
      end

      it 're-renders new view' do
        post :create, params: { answer: attributes_for(:answer, :invalid), question_id: question }
        expect(response).to render_template :new
      end
    end
  end

  describe "GET #destroy" do
    let!(:answer) { create(:answer) }
    it 'deleted the answer' do
      expect { delete :destroy, params: { id: answer } }.to change(Answer, :count).by(-1)
    end

    it 'redirects to question show' do
      delete :destroy, params: { id: answer }
      expect(response).to redirect_to questions_path
    end
  end
end