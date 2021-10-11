include Warden::Test::Helpers
module ControllerMacros
  def login_admin
    before do
      @request.env["devise_mapping"] = Devise.mappings[:user]
      sign_in FactoryBot.create :user, role: :admin
    end
  end
  def login_buyer
    before do
      @request.env["devise_mapping"] = Devise.mappings[:user]
      sign_in FactoryBot.create :user, role: :buyer
    end
  end
end
