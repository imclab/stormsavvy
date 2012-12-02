require 'spec_helper'

describe "user_mailer/pester_admins" do

  it "greet the admin user" do
    render
    rendered.should =~ /pester admin email/
  end

  it "contains  a projects table" do
    render
    rendered.should have_selector 'table.projects'
    rendered.should have_selector 'th', :text => "Projects"
  end

  it "contains  a forecast table" do
    render
    rendered.should have_selector 'table.forecast'
    rendered.should have_selector 'th', :text => "Forecast"
  end


end
