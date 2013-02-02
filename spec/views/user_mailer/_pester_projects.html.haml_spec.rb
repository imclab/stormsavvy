require 'spec_helper'

describe "user_mailer/_pester_projects" do
  it "contains a projects table" do
    render
    rendered.should have_selector 'table'
    rendered.should have_selector 'th', :text => "Projects"
  end
end