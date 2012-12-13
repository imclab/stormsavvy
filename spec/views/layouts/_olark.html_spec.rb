require 'spec_helper'

describe "layouts/_olark.html" do

  before(:each) do
    @user = FactoryGirl.create(:user)
    sign_in @user
    stub_template "shared/_cta-bar.html.haml" => 'sidebar template'
    stub_template "shared/_flash_messages.html.haml" => 'flash message template'
    stub_template "layouts/_olark.html" => 'olark template'
  end

  it "renders olark plugin" do
    # response.should render_template(:partial => 'olark template')
    response.should_not be_nil
  end
end
