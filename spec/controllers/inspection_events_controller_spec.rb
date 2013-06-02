require 'spec_helper'

describe InspectionEventsController do

  def valid_attributes
    {
      :site_id => 1,
      :inspection_type => "weekly",
      :inspection_description => "ec jungle gym inspection",
      :inspection_date => "2013-01-26 23:13:55",
      :submitted_by => "wyu",
      :inspected_by => "wyu"
    }
  end
  
  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # InspectionEventsController. Be sure to keep this updated too.
  def valid_session
    {}
  end

  describe "GET index" do
    it "assigns all inspection_events as @inspection_events" do
      inspection_event = InspectionEvent.create! valid_attributes
      get :index, {}, valid_session
      assigns(:inspection_events).should eq([inspection_event])
    end
  end

  describe "GET show" do
    it "assigns the requested inspection_event as @inspection_event" do
      inspection_event = InspectionEvent.create! valid_attributes
      get :show, {:id => inspection_event.to_param}, valid_session
      assigns(:inspection_event).should eq(inspection_event)
    end
  end

  describe "GET new" do
    it "assigns a new inspection_event as @inspection_event" do
      get :new, {}, valid_session
      assigns(:inspection_event).should be_a_new(InspectionEvent)
    end
  end

  describe "GET edit" do
    it "assigns the requested inspection_event as @inspection_event" do
      inspection_event = InspectionEvent.create! valid_attributes
      get :edit, {:id => inspection_event.to_param}, valid_session
      assigns(:inspection_event).should eq(inspection_event)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new InspectionEvent" do
        expect {
          post :create, {:inspection_event => valid_attributes}, valid_session
        }.to change(InspectionEvent, :count).by(1)
      end

      it "assigns a newly created inspection_event as @inspection_event" do
        post :create, {:inspection_event => valid_attributes}, valid_session
        assigns(:inspection_event).should be_a(InspectionEvent)
        assigns(:inspection_event).should be_persisted
      end

      it "redirects to the created inspection_event" do
        post :create, {:inspection_event => valid_attributes}, valid_session
        response.should redirect_to(InspectionEvent.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved inspection_event as @inspection_event" do
        # Trigger the behavior that occurs when invalid params are submitted
        InspectionEvent.any_instance.stub(:save).and_return(false)
        post :create, {:inspection_event => {}}, valid_session
        assigns(:inspection_event).should be_a_new(InspectionEvent)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        InspectionEvent.any_instance.stub(:save).and_return(false)
        post :create, {:inspection_event => {}}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested inspection_event" do
        inspection_event = InspectionEvent.create! valid_attributes
        # Assuming there are no other inspection_events in the database, this
        # specifies that the InspectionEvent created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        InspectionEvent.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, {:id => inspection_event.to_param, :inspection_event => {'these' => 'params'}}, valid_session
      end

      it "assigns the requested inspection_event as @inspection_event" do
        inspection_event = InspectionEvent.create! valid_attributes
        put :update, {:id => inspection_event.to_param, :inspection_event => valid_attributes}, valid_session
        assigns(:inspection_event).should eq(inspection_event)
      end

      it "redirects to the inspection_event" do
        inspection_event = InspectionEvent.create! valid_attributes
        put :update, {:id => inspection_event.to_param, :inspection_event => valid_attributes}, valid_session
        response.should redirect_to(inspection_event)
      end
    end

    describe "with invalid params" do
      it "assigns the inspection_event as @inspection_event" do
        inspection_event = InspectionEvent.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        InspectionEvent.any_instance.stub(:save).and_return(false)
        put :update, {:id => inspection_event.to_param, :inspection_event => {}}, valid_session
        assigns(:inspection_event).should eq(inspection_event)
      end

      it "re-renders the 'edit' template" do
        inspection_event = InspectionEvent.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        InspectionEvent.any_instance.stub(:save).and_return(false)
        put :update, {:id => inspection_event.to_param, :inspection_event => {}}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested inspection_event" do
      inspection_event = InspectionEvent.create! valid_attributes
      expect {
        delete :destroy, {:id => inspection_event.to_param}, valid_session
      }.to change(InspectionEvent, :count).by(-1)
    end

    it "redirects to the inspection_events list" do
      inspection_event = InspectionEvent.create! valid_attributes
      delete :destroy, {:id => inspection_event.to_param}, valid_session
      response.should redirect_to(inspection_events_url)
    end
  end

end
