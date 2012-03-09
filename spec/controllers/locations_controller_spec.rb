require 'spec_helper'

describe LocationsController do

  describe "GET 'index'" do
    xit "returns http success" do
      get Location.all
      response.should be_success
    end
  end

  describe "GET 'new'" do
    xit "returns http success" do
      # get Location.new
      # response.should be_success

      location = Location.create! valid_attributes
      get :new, {:id => location.to_param}, valid_session
      assigns(:location).should eq(location)
    end
  end

  describe "GET 'create'" do
    it "returns http success" do
      get 'create'
      response.should be_success
    end
  end

end
