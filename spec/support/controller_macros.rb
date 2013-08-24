module ControllerMacros

  def login_user
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:map]
      user = FactoryGirl.create(:user)
      user.confirm!
      sign_in
    end
  end

  def sign_in(user = double('user'))
    if user.nil?
      request.env['warden'].stub(:authenticate!).
      and_throw(:warden, {:scope => :user})
      controller.stub :current_user => nil
    else
      request.env['warden'].stub :authenticate! => user
      controller.stub :current_user => user
    end
  end
end
