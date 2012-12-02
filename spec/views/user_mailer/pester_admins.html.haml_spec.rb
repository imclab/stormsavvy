require 'spec_helper'

describe "user_mailer/pester_admins" do

  it "greet the admin user" do
    render
    rendered.should =~ /pester admin email/
  end

  it "contains table" do
    render
    rendered.should have_selector 'td'
    rendered.should have_selector 'tr'
  end
end
