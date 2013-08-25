require 'spec_helper'

describe AlertPagesController do

  include Devise::TestHelpers

  let(:user) {
    FactoryGirl.create(:user)
    # login_as(user, :scope => :user)
  }

  before :each do
    sign_in user
  end


  describe "GET 'sender'" do
    it "returns http success" do
      get 'sender'
      response.should be_success
    end
  end

  describe "GET 'thankyou'" do
    it "returns http success" do
      get 'thankyou'
      response.should be_success
    end
  end
end
