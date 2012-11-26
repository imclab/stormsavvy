module ControllerMacros

  def login_user
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:map]
      user = FactoryGirl.create(:user)
      user.confirm!
      sign_in
    end
  end
end
