require 'spec_helper'

describe "pages/index" do

  describe 'pages/index' do
    before do
      view.stub(:index).and_return(true)
    end

    it 'checks landing page' do
      render
      rendered.should have_selector('div#homeContent')
      rendered.should =~ /How Storm Savvy Works/
      rendered.should =~ /Step 1: Create Free Account/
      rendered.should =~ /Sign up by email, cancel any time/
      rendered.should =~ /Step 2: Dashboard Login/
      rendered.should =~ /View project and weather updates/
      rendered.should =~ /Step 3: Create New Sites/
      rendered.should =~ /Add name and zipcode/
      rendered.should =~ /Step 4: Start Tracking/
      rendered.should =~ /Share reports and updates/
    end
  end
end
