require 'spec_helper'

describe "user_mailer/mailout" do

  it "renders mailout mailer" do
    render
    rendered.should have_selector 'h2', :text => "Daily Project POP Alerts"
    rendered.should =~ /Daily Project POP Alerts/
  end

end
