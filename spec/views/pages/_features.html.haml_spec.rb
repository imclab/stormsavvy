require 'spec_helper'

describe "pages/index" do

  describe 'pages/index' do
    before do
      view.stub(:index).and_return(true)
    end

    it 'checks landing page' do
      render
      rendered.should have_selector('div#homeContent')
      rendered.should match(/Real-Time Stormwater Management/)
      rendered.should match(/How Storm Savvy Works/)
      rendered.should match(/Create Free Account/)
      rendered.should match(/Update Your Projects/)
      rendered.should match(/Check For Updates/)
    end
  end
end
