require 'spec_helper'

describe WeatherEventsController do

  def valid_attributes
    {}
  end

  def valid_session
    {}
  end

  describe "GET index" do
    it "assigns all weather_events as @weather_events" do
      get :index, {}, valid_session
      expect(assigns(:weather_events)).to eq(WeatherEvent.all)
    end
  end

  describe "GET show" do
    it "assigns the requested weather_event as @weather_event" do
      weather_event = WeatherEvent.create! valid_attributes
      get :show, {:id => weather_event.to_param}, valid_session
      assigns(:weather_event).should eq(weather_event)
    end
  end

  describe "GET new" do
    it "assigns a new weather_event as @weather_event" do
      get :new, {}, valid_session
      assigns(:weather_event).should be_a_new(WeatherEvent)
    end
  end

  describe "GET edit" do
    it "assigns the requested weather_event as @weather_event" do
      weather_event = WeatherEvent.create! valid_attributes
      get :edit, {:id => weather_event.to_param}, valid_session
      assigns(:weather_event).should eq(weather_event)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new WeatherEvent" do
        expect {
          post :create, {:weather_event => valid_attributes}, valid_session
        }.to change(WeatherEvent, :count).by(1)
      end

      it "assigns a newly created weather_event as @weather_event" do
        post :create, {:weather_event => valid_attributes}, valid_session
        assigns(:weather_event).should be_a(WeatherEvent)
        assigns(:weather_event).should be_persisted
      end

      it "redirects to the created weather_event" do
        post :create, {:weather_event => valid_attributes}, valid_session
        response.should redirect_to(WeatherEvent.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved weather_event as @weather_event" do
        # Trigger the behavior that occurs when invalid params are submitted
        WeatherEvent.any_instance.stub(:save).and_return(false)
        post :create, {:weather_event => {}}, valid_session
        assigns(:weather_event).should be_a_new(WeatherEvent)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        WeatherEvent.any_instance.stub(:save).and_return(false)
        post :create, {:weather_event => {}}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested weather_event" do
        weather_event = WeatherEvent.create! valid_attributes
        # Assuming there are no other weather_events in the database, this
        # specifies that the WeatherEvent created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        WeatherEvent.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, {:id => weather_event.to_param, :weather_event => {'these' => 'params'}}, valid_session
      end

      it "assigns the requested weather_event as @weather_event" do
        weather_event = WeatherEvent.create! valid_attributes
        put :update, {:id => weather_event.to_param, :weather_event => valid_attributes}, valid_session
        assigns(:weather_event).should eq(weather_event)
      end

      it "redirects to the weather_event" do
        weather_event = WeatherEvent.create! valid_attributes
        put :update, {:id => weather_event.to_param, :weather_event => valid_attributes}, valid_session
        response.should redirect_to(weather_event)
      end
    end

    describe "with invalid params" do
      it "assigns the weather_event as @weather_event" do
        weather_event = WeatherEvent.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        WeatherEvent.any_instance.stub(:save).and_return(false)
        put :update, {:id => weather_event.to_param, :weather_event => {}}, valid_session
        assigns(:weather_event).should eq(weather_event)
      end

      it "re-renders the 'edit' template" do
        weather_event = WeatherEvent.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        WeatherEvent.any_instance.stub(:save).and_return(false)
        put :update, {:id => weather_event.to_param, :weather_event => {}}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested weather_event" do
      weather_event = WeatherEvent.create! valid_attributes
      expect {
        delete :destroy, {:id => weather_event.to_param}, valid_session
      }.to change(WeatherEvent, :count).by(-1)
    end

    it "redirects to the weather_events list" do
      weather_event = WeatherEvent.create! valid_attributes
      delete :destroy, {:id => weather_event.to_param}, valid_session
      response.should redirect_to(weather_events_url)
    end
  end

end
