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

  it "has edit, back and delete links" do
    render
    rendered.should match(/Edit/)
    rendered.should match(/Back/)
    rendered.should match(/Delete/)

    rendered.should have_link('Edit')
    rendered.should have_link('Back')
    rendered.should have_button('Delete This Site')
  end

  xit "renders nested sites fields" do
    assert_select "form", :action => inspection_events_path, :method => "post" do
      assert_select(
        "input#inspection_event_sites_name",
        :name => "inspection_event[sites][name]",
        :size => 30,
        :type =>'text'
      )
      assert_select(
        "input#inspection_event_sites_description",
        :name => "inspection_event[sites][description]",
        :size => 30,
        :type =>'text'
      )
    end
  end

  xit 'renders correct css classes' do
    renders.should have_class('siteWrapper')
    renders.should have_class('siteInner')
  end

  xit 'renders nested site fields' do
    rendered.should have_text('Name')
    rendered.should have_text('Description')
  end
end
