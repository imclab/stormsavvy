require 'spec_helper'

describe "pages/_devise_signin" do

  before do
    view.stub(:index).and_return(true)
  end

  it 'checks signin partial view' do
    render
    rendered.should =~ /Sign in/
  end
end
