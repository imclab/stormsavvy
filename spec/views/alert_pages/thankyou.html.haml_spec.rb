require 'spec_helper'

describe "alert_pages/thankyou.html.haml" do
  it "thanks the user for sending him or herself email" do
    render
    rendered.should =~ /thank you/i
  end
end
