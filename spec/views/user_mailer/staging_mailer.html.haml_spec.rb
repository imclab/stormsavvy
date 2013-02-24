require 'spec_helper'

describe "user_mailer/staging_mailer" do

  before(:all) do
    @greeting = "Greetings"
  end

  it "renders staging_mailer" do
    render
    rendered.should have_selector 'h1', :text => 'Storm Savvy Staging App Email'
    rendered.should =~ /Storm Savvy Staging App Email/
  end
end
