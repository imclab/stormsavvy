require 'spec_helper'

describe "layouts/application.html.haml" do
  before(:each) do
    @user = FactoryGirl.create(:user)
    sign_in @user
    stub_template "shared/_cta-bar.html.haml" => 'sidebar template'
    stub_template "shared/_flash_messages.html.haml" => 'flash message template'
  end

  it "renders the sidebar" do
    render
    rendered.should contain 'sidebar template'
  end

  context "using content_for(:title)" do

    let(:page_title) { "StormSavvy" }
    let(:brand_title) { "Storm Savvy" }

    before do
      view.content_for(:title) { page_title }
      render
    end

    it "sets <title>" do
      rendered.should have_selector "title", :text => "#{page_title}"
      rendered.should have_selector "title", :text => "StormSavvy"
    end

    it "sets link and brand title" do
      rendered.should have_selector "a", :text => "#{brand_title}"
      rendered.should have_selector "a.brand", :text => "Storm Savvy"
      rendered.should_not have_selector "a.dskfjghsldfkjgh", :text => "Storm Savvy"
    end

  end
end
