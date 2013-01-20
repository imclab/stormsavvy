require 'spec_helper'

describe "pages/index" do

  describe "index page components" do

    it "renders index template" do
      # rendered.should have_selector('div#homeContent')
      render
      view.should render_template('pages/index')
    end
  end
end
