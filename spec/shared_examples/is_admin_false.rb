RSpec.shared_examples "when user isn't admin" do
  before do
    log_in buyer
    get :index
  end

  it "display flash message" do
    expect(flash[:warning]).to eq I18n.t("user.login.isnt_admin")
  end

  it "redirect to root path" do
    expect(response).to redirect_to root_url
  end

end
