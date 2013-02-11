require 'spec_helper'

describe "pages/_devise_signup" do

  before do
    view.stub(:index).and_return(true)
  end

  it 'checks signup partial view' do
    render
    rendered.should =~ /Already a member?/
  end
end
