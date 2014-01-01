require 'spec_helper'

describe "pages/index" do

  describe 'pages/index' do
    before do
      view.stub(:index).and_return(true)
    end

    it 'checks landing page' do
      render
      rendered.should have_selector('div#homeContent')
      # rendered.should =~ /Sign in/
    end
  end
end
