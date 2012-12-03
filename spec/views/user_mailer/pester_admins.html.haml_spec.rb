require 'spec_helper'

describe "user_mailer/pester_admins" do

  it "greet the admin user" do
    render
    rendered.should =~ /daily admin email/
  end

  it "contains a projects table" do
    render
    rendered.should have_selector 'table'
    rendered.should have_selector 'th', :text => "Projects"
  end

  it "contains a forecast table" do
    render
    rendered.should have_selector 'table'
    rendered.should have_selector 'th', :text => "Forecast"
  end

end

describe "user_mailer/_pester_intro_block" do

  it "renders the intro partial" do
    render
    rendered.should have_content "Storm Sumo"
  end
end
