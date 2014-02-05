require 'spec_helper'

describe "alert_mailer/pop_alert.html.haml" do

  it "renders POP alert" do
    render
    rendered.should =~ /NOAA POP Alert/
  end
end
