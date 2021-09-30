RSpec.shared_examples "when user hasn't logged in" do
  before{get :index}
  it "display flash message" do
    expect(flash[:warning]).to eq I18n.t("user.login.require")
  end

  it "redirect to login path" do
    expect(response).to redirect_to login_path
  end

end
