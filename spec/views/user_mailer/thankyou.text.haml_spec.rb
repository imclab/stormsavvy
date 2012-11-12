require 'spec_helper'

describe "user_mailer/thankyou" do

  it "thanks user for signing up" do
    render
    rendered.should =~ /Thank you/
  end

end
