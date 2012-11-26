require 'spec_helper'

describe "user_mailer/mailout" do

  it "render the mailout email template" do
    render
    rendered.should =~ /Your project alerts/
  end

end
