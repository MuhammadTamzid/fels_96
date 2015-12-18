require "rails_helper"

describe CategoriesController do
  let(:user){FactoryGirl.create :user}
  let!(:category){FactoryGirl.create :category}
  before{sign_in user}

  describe "GET #index" do
    before {get :index}
    context "get index successfully" do
      it {expect(response).to be_success}
      it {expect(response).to have_http_status 200}
      it {expect(assigns(:categories)).to eq([category])}
      it {expect(response).to render_template :index}
    end
  end
end
