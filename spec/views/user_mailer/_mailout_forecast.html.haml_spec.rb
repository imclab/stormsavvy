require 'spec_helper'

describe "user_mailer/_pester_forecast" do

  it "renders the forecast partial" do
    render
    rendered.should have_content "Site"
    rendered.should have_content "POP ="
  end

  it "contains a forecast table" do
    render
    rendered.should have_selector 'table'
    rendered.should have_selector 'tr', :text => "Site"
    rendered.should have_selector 'tr', :text => "POP ="
  end
end