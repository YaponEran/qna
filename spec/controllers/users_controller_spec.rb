require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'GET #show' do
    let(:user) { create(:user) }

    before { sign_in(user) }

    before { get :show }

    it 'renders show view' do
      expect(response).to render_template :show
    end
  end
end
