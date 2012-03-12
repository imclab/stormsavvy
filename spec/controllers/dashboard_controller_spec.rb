require 'spec_helper'

describe DashboardController do

  before(:each) do
    @user = Factory(:user)
    sign_in @user
  end

  describe "GET 'index' for signed in user" do
    it "returns http success" do
      get :index
      response.should be_success
    end
  end

  describe "GET 'index' for non-signed in user" do
    it "returns http success" do
      sign_out @user
      get :index
      response.should redirect_to index_path
    end
  end

end
