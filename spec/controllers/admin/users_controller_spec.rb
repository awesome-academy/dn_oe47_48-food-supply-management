require "rails_helper"

RSpec.describe Admin::UsersController, type: :controller do
  describe "#index" do
    let(:admin){FactoryBot.create :user, role: :admin}
    let!(:buyer){FactoryBot.create :user, role: :buyer}
    it_behaves_like "when user hasn't logged in" 
    context "when user logged in" do
      it_behaves_like "when user isn't admin"
      context "when user is admin" do
        login_admin
        it "assign @users" do
          get :index
          expect(assigns(:users)).to eq([buyer])
        end
        it "render the index template" do
          get :index, xhr: true
          expect(response).to render_template("index")
        end
      end
    end
  end
end
