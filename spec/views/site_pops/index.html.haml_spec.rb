require 'spec_helper'

describe "site_pops/index" do
  before(:each) do
    assign(:site_pops, [
      stub_model(SitePop),
      stub_model(SitePop)
    ])
  end

  it "renders a list of site_pops" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
