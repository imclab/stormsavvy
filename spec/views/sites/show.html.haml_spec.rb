require 'spec_helper'

describe "sites/show" do
  before(:each) do
    @site = assign(:site, stub_model(Site,
      :description => "Description",
      :costcode => "Costcode",
      :size => "Size",
      :exposed_area => "Exposed Area"
    ))
    @project = FactoryGirl.create(:project)
    @site.project_id = @project.id
  end

  it "renders attributes in <p>" do
    render
    rendered.should match(/Description/)
    rendered.should match(/Costcode/)
    rendered.should match(/Size/)
    rendered.should match(/Exposed Area/)
  end
end
