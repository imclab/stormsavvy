require 'spec_helper'

describe SamplingEventsController do

  include Devise::TestHelpers

  let(:user) {
    FactoryGirl.create(:user)
  }

  def valid_attributes
    {
      :site_id => 1,
      :sampling_type => "pH",
      :sampling_description => "ec jungle gym sampling",
      :sampling_date => "2013-01-27 15:34:07",
      :submitted_by => "wyu",
      :sampled_by => "wyu",
      :sample_id_1 => 1,
      :sample_location_1 => "jungle gym",
      :sample_time_1 => "2013-01-27 15:34:07",
      :analysis_type_1 => "pH",
      :analysis_result_1 => "7.00",
      :analysis_average_1 => "7.01",
      :sample_id_2 => 1,
      :sample_location_2 => "playground slide",
      :sample_time_2 => "2013-01-27 15:34:07",
      :analysis_type_2 => "pH",
      :analysis_result_2 => "7.10",
      :analysis_average_2 => "7.01",
      :sample_id_3 => 1,
      :sample_location_3 => "playground seesaw",
      :sample_time_3 => "2013-01-27 15:34:07",
      :analysis_type_3 => "pH",
      :analysis_result_3 => "6.90",
      :analysis_average_3 => "7.01",
      :sample_id_4 => 1,
      :sample_location_4 => "merry go round",
      :sample_time_4 => "2013-01-27 15:34:07",
      :analysis_type_4 => "pH",
      :analysis_result_4 => "6.95",
      :analysis_average_4 => "7.01",
      :sample_id_5 => 1,
      :sample_location_5 => "playground swings",
      :sample_time_5 => "2013-01-27 15:34:07",
      :analysis_type_5 => "pH",
      :analysis_result_5 => "7.20",
      :analysis_average_5 => "7.01"
    }
  end

  def valid_session
    { "warden.user.user.key" => session["warden.user.user.key"] }
  end

  let!(:current_user) { FactoryGirl.build(
      :user,
      email: 'me@stormsavvy.com'
    )
  }
  let(:other_user) { FactoryGirl.build(
      :user,
      email: 'info@stormsavvy.com'
    )
  }
  let(:all_users) { [ current_user, other_user ] }

  let!(:current_project) { FactoryGirl.build(
      :project,
      user: current_user
    )
  }
  let(:other_project) { FactoryGirl.build(
      :project,
      user: other_user
    )
  }
  let(:current_projects) { [ current_project ] }
  let(:other_projects) { [ other_project ] }
  let(:all_projects) { [ current_project, other_project ] }

  let!(:current_site) { FactoryGirl.create(
      :site,
      user: current_user,
      # project: current_project,
      name: 'ec jungle gym',
      zipcode: 94530
    )
  }
  let(:other_site) { FactoryGirl.create(
      :site,
      user: other_user,
      # project: other_project,
      name: 'berkeley high',
      zipcode: 94709
    )
  }
  let!(:current_sites) { [ current_site ] }
  let(:other_sites)  { [ other_site ] }
  let(:all_sites) { [ current_site, other_site ] }

  let!(:current_se) { FactoryGirl.create(
      :sampling_event,
      site: current_site
    )
  }
  let(:other_se) { FactoryGirl.create(
      :sampling_event,
      site: other_site
    )
  }
  let!(:current_se_array) { [ current_se ] }
  let(:other_se_array) { [ other_se ] }
  let(:all_se_array) { [ current_se, other_se ] }

  before(:each) do
    sign_in current_user
    sign_in other_user
    sign_in user
  end

  describe "GET index" do
    xit "assigns all sampling_events as @sampling_events" do
      get :index, {}, valid_session
      assigns(:sampling_events).should eq(SamplingEvent.all)
    end
  end

  describe "GET show" do
    it "assigns the requested sampling_event as @sampling_event" do
      sampling_event = SamplingEvent.create! valid_attributes
      get :show, {:id => sampling_event.to_param}, valid_session
      assigns(:sampling_event).should eq(sampling_event)
    end
  end

  describe "GET new" do
    it "assigns a new sampling_event as @sampling_event" do
      get :new, {}, valid_session
      assigns(:sampling_event).should be_a_new(SamplingEvent)
    end
  end

  describe "GET edit" do
    it "assigns the requested sampling_event as @sampling_event" do
      sampling_event = SamplingEvent.create! valid_attributes
      get :edit, {:id => sampling_event.to_param}, valid_session
      assigns(:sampling_event).should eq(sampling_event)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new SamplingEvent" do
        expect {
          post :create, {:sampling_event => valid_attributes}, valid_session
        }.to change(SamplingEvent, :count).by(1)
      end

      it "assigns a newly created sampling_event as @sampling_event" do
        post :create, {:sampling_event => valid_attributes}, valid_session
        assigns(:sampling_event).should be_a(SamplingEvent)
        assigns(:sampling_event).should be_persisted
      end

      it "redirects to the created sampling_event" do
        post :create, {:sampling_event => valid_attributes}, valid_session
        response.should redirect_to(SamplingEvent.last)
      end

      it "responds with flash message" do
        post :create, {:sampling_event => valid_attributes}, valid_session
        flash[:notice].should == "Sampling event was successfully created."
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved sampling_event as @sampling_event" do
        SamplingEvent.any_instance.stub(:save).and_return(false)
        post :create, {:sampling_event => { "site_id" => "invalid value" }}, valid_session
        assigns(:sampling_event).should be_a_new(SamplingEvent)
      end

      it "re-renders the 'new' template" do
        SamplingEvent.any_instance.stub(:save).and_return(false)
        post :create, {:sampling_event => {}}, valid_session
        response.should render_template("new")
      end

      it "responds with flash message" do
        SamplingEvent.any_instance.stub(:save).and_return(false)
        post :create, {:sampling_event => {}}, valid_session
        # post :create, {:site => valid_attributes, :project_id => @project.id}
        response.should render_template('new')
        flash[:error].should == 'Error: See details below.'
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested sampling_event" do
        sampling_event = SamplingEvent.create! valid_attributes
        SamplingEvent.any_instance.should_receive(:update_attributes).with({ "site_id" => "1" })
        put :update, {:id => sampling_event.to_param, :sampling_event => { "site_id" => "1" }}, valid_session
      end

      it "assigns the requested sampling_event as @sampling_event" do
        sampling_event = SamplingEvent.create! valid_attributes
        put :update, {:id => sampling_event.to_param, :sampling_event => valid_attributes}, valid_session
        assigns(:sampling_event).should eq(sampling_event)
      end

      it "redirects to the sampling_event" do
        sampling_event = SamplingEvent.create! valid_attributes
        put :update, {:id => sampling_event.to_param, :sampling_event => valid_attributes}, valid_session
        response.should redirect_to(sampling_event)
      end

      it "responds with flash message" do
        sampling_event = SamplingEvent.create! valid_attributes
        put :update, {:id => sampling_event.to_param, :sampling_event => valid_attributes}, valid_session
        # post :create, {:site => valid_attributes, :project_id => @project.id}
        flash[:notice].should == "Sampling event was successfully updated."
      end
    end

    describe "with invalid params" do
      it "assigns the sampling_event as @sampling_event" do
        sampling_event = SamplingEvent.create! valid_attributes
        SamplingEvent.any_instance.stub(:save).and_return(false)
        put :update, {:id => sampling_event.to_param, :sampling_event => { "site_id" => "invalid value" }}, valid_session
        assigns(:sampling_event).should eq(sampling_event)
      end

      it "re-renders the 'edit' template" do
        sampling_event = SamplingEvent.create! valid_attributes
        SamplingEvent.any_instance.stub(:save).and_return(false)
        put :update, {:id => sampling_event.to_param, :sampling_event => { "site_id" => "invalid value" }}, valid_session
        response.should render_template("edit")
      end

      it "responds with flash message" do
        sampling_event = SamplingEvent.create! valid_attributes
        SamplingEvent.any_instance.stub(:save).and_return(false)
        put :update, {:id => sampling_event.to_param, :sampling_event => {}}, valid_session
        response.should render_template('edit')
        flash[:error].should == 'Error: See details below.'
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested sampling_event" do
      sampling_event = SamplingEvent.create! valid_attributes
      expect {
        delete :destroy, {:id => sampling_event.to_param}, valid_session
      }.to change(SamplingEvent, :count).by(-1)
    end

    it "redirects to the sampling_events list" do
      sampling_event = SamplingEvent.create! valid_attributes
      delete :destroy, {:id => sampling_event.to_param}, valid_session
      response.should redirect_to(sampling_events_path)
    end

    it "responds with flash message" do
      sampling_event = SamplingEvent.create! valid_attributes
      delete :destroy, {:id => sampling_event.to_param}, valid_session
      flash[:notice].should == 'Sampling event was successfully deleted.'
    end
  end

  describe '#get_se'  do
    it 'returns pending se from lib class' do
      cu = CurrentUserObject.new
      se = cu.get_se(current_user)
      se.should == current_se_array
    end
  end

  describe '#all_se'  do
    it 'returns all se from lib class' do
      cu = CurrentUserObject.new
      se = cu.all_se(current_user)
      se.should == current_se_array
    end
  end
end
