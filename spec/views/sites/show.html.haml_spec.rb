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
    rendered.should match(/Address 1/)
    rendered.should match(/Address 2/)
    rendered.should match(/City/)
    rendered.should match(/State/)
    rendered.should match(/Zipcode/)
  end

  it "has Edit / Back / Delete" do
    render
    rendered.should match(/Edit/)
    rendered.should match(/Back/)
    rendered.should match(/Delete/)
  end
end
