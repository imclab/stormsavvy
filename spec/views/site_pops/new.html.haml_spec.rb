require 'spec_helper'

describe "site_pops/new" do
  before(:each) do
    assign(:site_pop, stub_model(SitePop).as_new_record)
  end

  it "renders new site_pop form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => site_pops_path, :method => "post" do
    end
  end
end
