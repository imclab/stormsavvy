require 'spec_helper'

describe "sites/show" do
  before(:each) do
    @site = assign(:site, stub_model(Site,
      :description => "Description",
      :costcode => "Costcode",
      :size => "Size",
      :exposed_area => "Exposed Area",
      :location => "Location"
    ))
    @project = Factory(:project)
    @site.project_id = @project.id
  end

  xit "renders attributes in <p>" do
    render
    rendered.should match(/Description/)
    rendered.should match(/Costcode/)
    rendered.should match(/Size/)
    rendered.should match(/Exposed Area/)
    rendered.should match(/Location/)
  end
end
