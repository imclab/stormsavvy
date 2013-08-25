require 'spec_helper'

describe NoaaController do

  include Devise::TestHelpers

  let(:user) {
    FactoryGirl.create(:user)
    # login_as(user, :scope => :user)
  }

  before :each do
    sign_in user
  end

  describe "GET 'secret'" do
    it "returns http success" do
      get 'secret'
      response.should be_success
    end
  end
end
