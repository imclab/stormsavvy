require 'spec_helper'

describe PagesController do

  before(:each) do
    @user = FactoryGirl.create(:user)
    sign_in @user
  end

  describe "GET 'index'" do
    it "returns success" do
      render_template('pages/_hero')
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
      get :features
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
end
