require 'spec_helper'

describe "alert_pages/sender.html.haml" do
  it "has a send link on the page for sending email" do    
    render    
    rendered.should have_selector('a')
  end
end
