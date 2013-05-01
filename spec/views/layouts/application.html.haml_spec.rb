require 'spec_helper'

describe "layouts/application.html.haml" do

  before(:each) do
    @user = FactoryGirl.create(:user)
    sign_in @user
    stub_template "shared/_google_analytics.html.haml" => 'google analytics header'
    stub_template "shared/_flash_messages.html.haml" => 'flash message template'
    stub_template "shared/_hero.html.haml" => 'hero copy template'
  end

  context "using content_for(:title)" do

    let(:page_title) { "Storm Savvy" }
    let(:brand_title) { "Storm Savvy" }

    before do
      view.content_for(:title) { page_title }
      render
    end

    it "sets <title>" do
      # rendered.should have_selector "title", :text => "#{page_title}"
      rendered.should have_selector "title", :text => "Storm Savvy"
    end

    it "sets link and brand title" do
      rendered.should have_selector "a", :text => "#{brand_title}"
      rendered.should have_selector "a.brand", :text => "Storm Savvy"
      rendered.should_not have_selector "a.random_text", :text => "Storm Savvy"
    end
  end

  describe 'navbar' do
    it 'has correct links' do
      render
      rendered.should match(/Inspections/)
      rendered.should match(/Sampling/)
    end
  end

  describe 'flash message' do
    it "displays flash message" do
      flash[:error] = "Form fields are incorrect"
      render
      rendered.should have_selector('div.alert-error')#, :class => twitterized_type(:alert), :count => 1)
    end
  end
end
