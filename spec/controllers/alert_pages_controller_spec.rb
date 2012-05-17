require 'spec_helper'

describe AlertPagesController do

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
