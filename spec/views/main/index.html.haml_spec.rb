require 'spec_helper'

describe "main/index.html.erb" do

  before do
    view.stub(:index).and_return(true)
  end

  it 'checks maincopy partial view' do
    render
    response.code.should == 200
  end
end
