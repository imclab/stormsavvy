require 'spec_helper'

describe "pages/_maincopy" do

  before do
    view.stub(:index).and_return(true)
  end

  it 'checks maincopy partial view' do
    render
    rendered.should match(/Real-Time Stormwater Management/)
    rendered.should match(/Effective, Efficient Permit Compliance/)
    rendered.should match(/Get Storm Savvy Now/)
  end
end
