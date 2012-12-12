require 'spec_helper'

describe ApplicationController do
  render_views

	describe "layouts/application.html.haml" do
	  before(:each) do
	    @user = FactoryGirl.create(:user)
	    sign_in @user
      # get :index
	    # stub_template "shared/_cta-bar.html.haml" => 'sidebar template'
	    # stub_template "shared/_flash_messages.html.haml" => 'flash message template'
	  end

	  it "renders the sidebar" do
	    response.should render_template 'sidebar template'
	  end
	end
end
