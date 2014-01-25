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

  it "generates a pdf with CEM2030" do
    format = double("format")
    format.stub(:CEM2030).and_return "CEM2030.pdf"
    controller.stub(:respond_to).and_yield(format)

    get :CEM2030
    response.code.should eq("200")
    pp response

    controller.should_receive(:CEM2030)
    get :CEM2030, :format => :pdf
  end

end
