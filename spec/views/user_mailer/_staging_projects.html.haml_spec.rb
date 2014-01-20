require 'spec_helper'

describe "user_mailer/_staging_projects" do
  it "contains a projects table" do
    render
    rendered.should have_selector 'table'
    rendered.should have_selector 'th', :text => "Projects"
    rendered.should have_selector 'th', :text => "Users"
    rendered.should have_selector 'th', :text => "Sites"
    rendered.should have_selector 'th', :text => "Inspections"
    rendered.should have_selector 'th', :text => "Reports"
  end
end
