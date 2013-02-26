require 'spec_helper'

describe "pages/pdf" do

  context "using content_for(:leaderboard)" do

    let(:main_title) { "PDF Reports" }
    let(:main_tagline) { "Instructions: Select From Forms Below" }

    before do
      view.content_for(:h1) { main_title }
      view.content_for(:h3) { main_tagline }

      view.stub(:pdf).and_return(true)
      render
    end

    it "has correct link text" do
      render
      rendered.should =~ /CEM 2030/
      rendered.should =~ /CEM 2034/
      rendered.should =~ /CEM 2035/
      rendered.should =~ /CEM 2040/
      rendered.should =~ /CEM 2045/
      rendered.should =~ /CEM 4601/
      
      # rendered.should have_link 'pdf_CEM2030_path'
      # rendered.should have_link 'pdf_CEM2034_path'
      # rendered.should have_link 'pdf_CEM2035_path'
      # rendered.should have_link 'pdf_CEM2040_path'
      # rendered.should have_link 'pdf_CEM2045_path'
    end

    it "sets <h1> and <h3>" do
      rendered.should have_selector "leaderboard", :text => "#{main_title}"
      rendered.should have_selector "leaderboard", :text => "#{main_tagline}"
    end

    # it "sets main title and tagline" do
    #   rendered.should have_selector "hero"
    #   rendered.should have_selector "h1", :text => "#{main_title}"
    #   rendered.should have_selector "h3", :text => "#{main_tagline}"
    #   rendered.should_not have_selector "asdf", :text => "#{main_title}"
    #   rendered.should_not have_selector "asdf", :text => "#{main_tagline}"
    # end
  end
end
