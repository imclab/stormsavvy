require 'spec_helper'

describe "site_pops/show" do
  before(:each) do
    @site_pop = assign(:site_pop, stub_model(SitePop))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
