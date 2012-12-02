require 'spec_helper'

describe "pages/pdf.html.haml" do

  before(:each) do
    stub_template "pages/pdf.html.haml" => 'pdf pages template'
  end

  context "using content_for(:main_copy)" do

    let(:main_title) { "Storm Savvy PDFs" }
    let(:main_tagline) { "Forms On The Go" }

    before do
      view.content_for(:h1) { main_title }
      view.content_for(:h3) { main_tagline }
      render
    end

    # it "sets <h1> and <h3>" do
    #   rendered.should have_selector "main_copy", :text => "#{main_title}"
    #   rendered.should have_selector "main_copy", :text => "#{main_tagline}"
    # end

    # it "sets main title and tagline" do
    #   rendered.should have_selector "hero"
    #   rendered.should have_selector "h1", :text => "#{main_title}"
    #   rendered.should have_selector "h3", :text => "#{main_tagline}"
    #   rendered.should_not have_selector "asdf", :text => "#{main_title}"
    #   rendered.should_not have_selector "asdf", :text => "#{main_tagline}"
    # end
  end
end
