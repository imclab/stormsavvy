require 'spec_helper'

describe "user_mailer/pester_admins" do

  before(:all) do
    @greeting = "Foobar"
    @forecast1 = [{ :date => "today", :weather => "90" }]
  end

  it "greet the admin user" do
    render
    rendered.should =~ /Daily Admin Email/
  end
end