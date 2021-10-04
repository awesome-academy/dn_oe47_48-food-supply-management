require "rails_helper"
require_relative "./../../support/devise"

RSpec.describe Admin::AdminsController, type: :controller do
  describe "GET #index" do
    it_behaves_like "when user hasn't logged in", :index
    context "when user logged in" do
      it_behaves_like "when user isn't admin", :index
      it "when user is admin" do
        expect(response).to have_http_status(200)
      end
    end
  end
end
