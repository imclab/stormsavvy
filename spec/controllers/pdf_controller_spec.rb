require 'spec_helper'

describe PdfController do

  include Devise::TestHelpers

  let!(:user) {
    FactoryGirl.create(:user)
  }

  before :each do
    sign_in user
  end

  it "renders methods with 200 code" do
    get :CEM2034
    response.code.should eq("200")
    get :CEM2035
    response.code.should eq("200")
    get :CEM2040
    response.code.should eq("200")
    get :CEM2045
    response.code.should eq("200")
    # get :CEM2050
    # response.code.should eq("200")
    # get :CEM2051
    # response.code.should eq("200")
    # get :CEM2052
    # response.code.should eq("200")
    get :CEM4601
    response.code.should eq("200")
  end

end
