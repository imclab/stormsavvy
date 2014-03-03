require 'spec_helper'

describe "user_mailer/thankyou" do
  it "thanks user for signing up" do
    render
    rendered.should have_selector 'table'
    rendered.should have_selector 'h1', :text => "Welcome to Storm Savvy!"
  end
end
