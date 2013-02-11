require 'spec_helper'

describe "pages/_maincopy" do

  before do
    view.stub(:index).and_return(true)
  end

  it 'checks maincopy partial view' do
    render
    rendered.should =~ /Making SWPPP Easy/
    rendered.should =~ /Free Email Alerts & Reports/
    rendered.should =~ /Sign Up Now For Free Access/
  end
end
