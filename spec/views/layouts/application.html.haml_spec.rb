#application.html.haml_spec.rb

require 'spec_helper'

describe "layouts/application.html.haml" do
  before do
    stub_template "shared/_cta-bar.html.haml" => 'sidebar template'
    stub_template "shared/_flash_messages.html.haml" => 'flash message template'
  end

  it "renders the sidebar" do
    render
    rendered.should contain 'sidebar template'
  end

  context "using content_for(:title)" do
    let(:page_title) { "Building This Site" }

    before do
      view.content_for(:title) { page_title }
      render
    end

    it "sets <title>" do
      rendered.should have_selector :title,
        :content => "aRailsDemo | #{page_title}"
    end

    it "sets <h1>" do
      rendered.should have_selector :h1,
        :content => page_title
    end
  end
end
