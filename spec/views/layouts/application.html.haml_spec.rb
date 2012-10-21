#application.html.haml_spec.rb

require 'spec_helper'

describe "layouts/application.html.haml" do
  before(:each) do
    @user = FactoryGirl.create(:user)
    sign_in @user
    stub_template "shared/_cta-bar.html.haml" => 'sidebar template'
    stub_template "shared/_flash_messages.html.haml" => 'flash message template'
  end

=begin
  it "renders the sidebar" do
    render 
    rendered.should contain 'sidebar template'
  end
=end

  context "using content_for(:title)" do
    let(:page_title) { "Building This Site" }

    before do
      view.content_for(:title) { page_title }
      render
    end

    xit "sets <title>" do
      rendered.should have_selector :title,
        :content => "aRailsDemo | #{page_title}"
    end

    xit "sets <h1>" do
      rendered.should have_selector :h1,
        :content => page_title
    end
  end
end
