require 'spec_helper'

describe "site_pops/edit" do
  before(:each) do
    @site_pop = assign(:site_pop, stub_model(SitePop))
  end

  it "renders the edit site_pop form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => site_pops_path(@site_pop), :method => "post" do
    end
  end
end
