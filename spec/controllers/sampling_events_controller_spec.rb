require 'spec_helper'

describe SamplingEventsController do

  # This should return the minimal set of attributes required to create a valid
  # SamplingEvent. As you add validations to SamplingEvent, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    { 
      "site_id" => "1" 
          site_id 1
    "sampling_type" => "pH"
    "sampling_description" => "ec jungle gym samplng"
    "sampling_date" => "2013-01-27 15:34:07"
    "submitted_by" => "wyu"
    "sampled_by" => "wyu"
    "sample_id_1" => 1
    "sample_location_1" => "jungle gym"
    "sample_time_1" => "2013-01-27 15:34:07"
    "analysis_type_1" => "pH"
    "analysis_result_1" => "7.00"
    "analysis_average_1" => "7.01"
    "sample_id_2" => 1
    "sample_location_2" => "playground slide"
    "sample_time_2" => "2013-01-27 15:34:07"
    "analysis_type_2" => "pH"
    "analysis_result_2" => "7.10"
    "analysis_average_2" => "7.01"
    "sample_id_3" => 1
    "sample_location_3" => "playground seesaw"
    "sample_time_3" => "2013-01-27 15:34:07"
    "analysis_type_3" => "pH"
    "analysis_result_3" => "6.90"
    "analysis_average_3" => "7.01"
    "sample_id_4" => 1
    "sample_location_4" => "merry go round"
    "sample_time_4" => "2013-01-27 15:34:07"
    "analysis_type_4" => "pH"
    "analysis_result_4" => "6.95"
    "analysis_average_4" => "7.01"
    "sample_id_5" => 1
    "sample_location_5" => "playground swings"
    "sample_time_5" => "2013-01-27 15:34:07"
    "analysis_type_5" => "pH"
    "analysis_result_5" => "7.20"
    "analysis_average_5" => "7.01"
    }
  end

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # SamplingEventsController. Be sure to keep this updated too.
  def valid_session
    {}
  end

  describe "GET index" do
    it "assigns all sampling_events as @sampling_events" do
      sampling_event = SamplingEvent.create! valid_attributes
      get :index, {}, valid_session
      assigns(:sampling_events).should eq([sampling_event])
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
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved sampling_event as @sampling_event" do
        # Trigger the behavior that occurs when invalid params are submitted
        SamplingEvent.any_instance.stub(:save).and_return(false)
        post :create, {:sampling_event => { "site_id" => "invalid value" }}, valid_session
        assigns(:sampling_event).should be_a_new(SamplingEvent)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        SamplingEvent.any_instance.stub(:save).and_return(false)
        post :create, {:sampling_event => { "site_id" => "invalid value" }}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested sampling_event" do
        sampling_event = SamplingEvent.create! valid_attributes
        # Assuming there are no other sampling_events in the database, this
        # specifies that the SamplingEvent created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
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
    end

    describe "with invalid params" do
      it "assigns the sampling_event as @sampling_event" do
        sampling_event = SamplingEvent.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        SamplingEvent.any_instance.stub(:save).and_return(false)
        put :update, {:id => sampling_event.to_param, :sampling_event => { "site_id" => "invalid value" }}, valid_session
        assigns(:sampling_event).should eq(sampling_event)
      end

      it "re-renders the 'edit' template" do
        sampling_event = SamplingEvent.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        SamplingEvent.any_instance.stub(:save).and_return(false)
        put :update, {:id => sampling_event.to_param, :sampling_event => { "site_id" => "invalid value" }}, valid_session
        response.should render_template("edit")
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
      response.should redirect_to(sampling_events_url)
    end
  end

end
