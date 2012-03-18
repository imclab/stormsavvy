require 'spec_helper'

# Probably, these should be request specs...
describe PagesController do

  describe "GET 'index'" do
    it "returns success" do
      get :index
      response.should be_success
    end
  end

  describe "Get 'about'" do
    it "returns success" do
      get :about
      response.should be_success
    end
  end

  describe "Get 'terms'" do
    it "returns success" do
      get :terms
      response.should be_success
    end
  end

  describe "Get 'faq'" do
    it "returns success" do
      get :faq
      response.should be_success
    end
  end

  describe "Get 'privacy'" do
    it "returns success" do
      get :privacy
      response.should be_success
    end
  end

  describe "Get 'contact'" do
    it "returns success" do
      get :contact
      response.should be_success
    end
  end

  describe "Get 'plans'" do
    it "returns success" do
      get :plans
      response.should be_success
    end
  end

  describe "Get 'features'" do
    it "returns success" do
      get :team
      response.should be_success
    end
  end

  describe "Get 'team'" do
    it "returns success" do
      get :team
      response.should be_success
    end
  end

  describe "Get 'POP email'" do
    it "returns success" do
      get :popemail
      response.should be_success
    end
  end

=begin
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
=end

end
