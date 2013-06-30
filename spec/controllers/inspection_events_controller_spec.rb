require 'spec_helper'
require 'current_user_object'

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

  def valid_session
    {}
  end

  let(:current_user) { FactoryGirl.build(
      :user,
      :email => '@stormsavvy.com'
    )
  }

  before(:each) do
    # @current_user = FactoryGirl.build(
    #   :user,
    #   :email => '@stormsavvy.com'
    # )
    @other_user = FactoryGirl.build(
      :user,
      :email => 'info@stormsavvy.com'
    )
    @all_users = [ @current_user, @other_user ]

    @current_project = FactoryGirl.create(
      :project,
      :user => @current_user
    )
    @other_project = FactoryGirl.create(
      :project,
      :user => @other_user
    )
    @current_projects = [ @current_project ]
    @other_projects = [ @other_project ]
    @all_projects = [ @current_project, @other_project ]

    @current_site = FactoryGirl.create(
      :site,
      :project => @current_project,
      :name => 'ec jungle gym',
      :zipcode => 94530
    )
    @other_site = FactoryGirl.create(
      :site,
      :project => @other_project,
      :name => 'berkeley high',
      :zipcode => 94709
    )
    @current_sites = [ @current_site ]
    @other_sites = [ @other_site ]
    @all_sites = [ @current_site, @other_site ]

    @current_ie = FactoryGirl.create(
      :inspection_event,
      :site => @current_site
    )
    @other_ie = FactoryGirl.create(
      :inspection_event,
      :site => @other_site
    )
    @current_ie_array = [ @current_ie ]
    @other_ie_array = [ @other_ie ]
    @all_ie_array = [ @current_ie, @other_ie ]

    @completed_report = FactoryGirl.create(
      :report,
      :site => @current_site,
      :status => "completed"
    )
    @pending_report = FactoryGirl.create(
      :report,
      :site => @current_site,
      :status => "needs_attention"
    )
    @completed_reports = [ @completed_report ]
    @pending_reports = [ @pending_report ]
    @all_reports = [ @completed_report, @pending_report ]

    sign_in current_user
    sign_in @other_user
  end

  describe "GET index" do
    it "assigns all inspection_events as @inspection_events" do
      # inspection_event = InspectionEvent.create! valid_attributes
      get :index, {}, valid_session
      assigns(:inspection_events).should eq(InspectionEvent.all)
    end
  end

  describe "GET show" do
    it "assigns the requested inspection_event as @inspection_event" do
      inspection_event = InspectionEvent.create! valid_attributes
      get :show, {:id => inspection_event.to_param}, valid_session
      assigns(:inspection_event).should eq(inspection_event)
      assigns(:inspection_event).should be_persisted
    end
  end

  describe "GET new" do
    it "assigns a new inspection_event as @inspection_event" do
      get :new, {}, valid_session
      assigns(:inspection_event).should be_a_new(InspectionEvent)
      assigns(:inspection_event).should_not be_persisted
    end

    describe 'with invalid params' do
      it "re-renders the 'new' template" do
        sign_in current_user
        InspectionEvent.any_instance.stub(:save).and_return(false)
        get :new, {:inspection_event => {}}, valid_session
        response.should render_template('new')
      end
    end
  end

  describe "GET edit" do
    it "assigns the requested inspection_event as @inspection_event" do
      inspection_event = InspectionEvent.create! valid_attributes
      get :edit, {:id => inspection_event.to_param}, valid_session
      assigns(:inspection_event).should eq(inspection_event)
      assigns(:inspection_event).should be_persisted
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

      it "responds with flash message" do
        sign_in current_user
        post :create, {:inspection_event => valid_attributes}, valid_session
        flash[:notice].should == "Inspection event was successfully created."
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved inspection_event as @inspection_event" do
        # Trigger the behavior that occurs when invalid params are submitted
        InspectionEvent.any_instance.stub(:save).and_return(false)
        post :create, {:inspection_event => {}}, valid_session
        assigns(:inspection_event).should be_a_new(InspectionEvent)
        assigns(:inspection_event).should_not be_persisted
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        InspectionEvent.any_instance.stub(:save).and_return(false)
        post :create, {:inspection_event => {}}, valid_session
        response.should render_template("new")
      end

      it "responds with flash message" do
        sign_in current_user
        InspectionEvent.any_instance.stub(:save).and_return(false)
        post :create, {:inspection_event => {}}, valid_session
        # post :create, {:site => valid_attributes, :project_id => @project.id}
        response.should render_template('new')
        flash[:error].should == 'Error: See details below.'
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested inspection_event" do
        inspection_event = InspectionEvent.create! valid_attributes
        InspectionEvent.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, {:id => inspection_event.to_param, :inspection_event => {'these' => 'params'}}, valid_session
      end

      it "assigns the requested inspection_event as @inspection_event" do
        inspection_event = InspectionEvent.create! valid_attributes
        put :update, {:id => inspection_event.to_param, :inspection_event => valid_attributes}, valid_session
        assigns(:inspection_event).should eq(inspection_event)
        assigns(:inspection_event).should be_persisted
      end

      it "redirects to the inspection_event" do
        inspection_event = InspectionEvent.create! valid_attributes
        put :update, {:id => inspection_event.to_param, :inspection_event => valid_attributes}, valid_session
        response.should redirect_to(inspection_event)
      end

      it "responds with flash message" do
        sign_in current_user
        inspection_event = InspectionEvent.create! valid_attributes
        put :update, {:id => inspection_event.to_param, :inspection_event => valid_attributes}, valid_session
        # post :create, {:site => valid_attributes, :project_id => @project.id}
        flash[:notice].should == "Inspection event was successfully updated."
      end
    end

    describe "with invalid params" do
      it "assigns the inspection_event as @inspection_event" do
        inspection_event = InspectionEvent.create! valid_attributes
        InspectionEvent.any_instance.stub(:save).and_return(false)
        put :update, {:id => inspection_event.to_param, :inspection_event => {}}, valid_session
        assigns(:inspection_event).should eq(inspection_event)
        assigns(:inspection_event).should be_persisted
      end

      it "re-renders the 'edit' template" do
        inspection_event = InspectionEvent.create! valid_attributes
        InspectionEvent.any_instance.stub(:save).and_return(false)
        put :update, {:id => inspection_event.to_param, :inspection_event => {}}, valid_session
        response.should render_template("edit")
      end

      it "responds with flash message" do
        sign_in current_user
        inspection_event = InspectionEvent.create! valid_attributes
        InspectionEvent.any_instance.stub(:save).and_return(false)
        put :update, {:id => inspection_event.to_param, :inspection_event => {}}, valid_session
        response.should render_template('edit')
        flash[:error].should == 'Error: See details below.'
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

    it "responds with flash message" do
      sign_in current_user
      inspection_event = InspectionEvent.create! valid_attributes
      delete :destroy, {:id => inspection_event.to_param}, valid_session
      flash[:notice].should == 'Inspection event was successfully deleted.'
    end
  end

  describe "current_user variables: users, projects and sites" do
    it 'returns current projects and sites' do
      sign_in @current_user
      @current_projects.should == @current_user.projects.all
      @current_projects.should_not include(@other_projects)
      @current_projects.should_not be_nil

      @current_sites.should == @current_user.sites.all
      @current_sites.should_not include(@other_sites)
      @current_sites.should_not be_nil
    end

    it "returns pending inspection events" do
      @current_ie_array.should == @current_site.inspection_events.where(:completed => false)
      @current_ie_array.should_not include(@other_ie)
    end
  end

  describe '#get_ie'  do
    it 'returns pending ie from lib class' do
      cu = CurrentUserObject.new
      ie = cu.get_ie(@current_user)
      ie.should == @current_ie_array
    end
  end

  describe '#all_ie'  do
    it 'returns all ie from lib class' do
      cu = CurrentUserObject.new
      ie = cu.all_ie(@current_user)
      ie.should == @current_ie_array
    end
  end
end
