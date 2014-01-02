require 'spec_helper'

describe "pages/_maincopy" do

  before do
    view.stub(:index).and_return(true)
  end

  it 'checks maincopy partial view' do
    render
    rendered.should =~ /Protect the Environment,/
    rendered.should =~ /Together and In Real-Time/
    rendered.should =~ /Sign up now to start tracking projects, together/
  end
end
