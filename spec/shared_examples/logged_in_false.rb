RSpec.shared_examples "when user hasn't logged in" do |action|
  before do
    get action, params:{locale: :en}
  end

  it "display flash message" do
    expect(flash[:alert]).to eq I18n.t("devise.failure.unauthenticated")
  end
  it "redirect to login path" do
    expect(response).to redirect_to login_path
  end

end
