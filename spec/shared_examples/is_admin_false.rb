RSpec.shared_examples "when user isn't admin" do |action|
  describe "when user isn't admin" do
    login_buyer
    before do
      get action, params:{locale: :en}
    end
    it "rescues from AccessDenied" do
      is_expected.to rescue_from(CanCan::AccessDenied)
    end
    it "display flash message" do
      expect(flash[:warning]).to eq I18n.t("unauthorized.manage.all")
    end
    it "redirect to root path" do
      expect(response).to redirect_to root_path
    end
  end
 

end
