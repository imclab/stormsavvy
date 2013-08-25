require 'spec_helper'

describe LocationsController do

  include Devise::TestHelpers

  let(:user) {
    FactoryGirl.create(:user)
    # login_as(user, :scope => :user)
  }

  before :each do
    sign_in user
  end


  def valid_attributes
    {}
  end

  describe "GET 'index'" do
    it "returns http success" do
      get :index
      response.should be_success
    end
  end

  describe "GET 'new'" do
    it "returns http success" do
      # get Location.new
      # response.should be_success
      #location = Location.create! valid_attributes
      #get :new, {:id => location.to_param}
      #assigns(:location).should eq(location)
      get :new
      response.should be_success
    end
  end

  describe "GET 'create'" do
    it "returns http success" do
      get 'create'
      response.should be_success
    end
  end

end
