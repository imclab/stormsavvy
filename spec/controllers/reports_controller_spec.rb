require 'spec_helper'

describe ReportsController do

  # Setup valid session values:
  def valid_attributes
    {}
  end

  def valid_session
    {}
  end

  describe "GET index" do

    it "renders the index template" do
      get :index
      response.should render_template("index")
    end
  end

  describe "GET show" do
    it "assigns requested report as @report" do
      report = Report.create! valid_attributes
      get :show, {:id => report.to_param}, valid_session
      assigns(:report).should eq(report)
    end

    it "renders png from app/assets/images directory" do
      # Write prawn spec here
    end
  end

  describe "GET new" do
    it "assigns new report as @report" do
      get :new, {}, valid_session
      assigns(:report).should be_a_new(Report)
    end
  end

  describe "GET edit" do
    it "assigns requested report as @report" do
      report = Report.create! valid_attributes
      get :edit, {:id => report.to_param}, valid_session
      assigns(:report).should eq(report)
    end
  end

  describe "POST create" do

    before :each do
      post :create, {:report => valid_attributes}, valid_session
    end

    describe "with valid params" do
      it "creates new Report" do
        expect {
          post :create, {:report => valid_attributes}, valid_session
        }.to change(Report, :count).by(1)
      end

      it "assigns newly created report as @report" do
        assigns(:report).should be_a(Report)
        assigns(:report).should be_persisted
      end

      it "redirects to the created inspection_event" do
        response.should redirect_to(Report.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved report as @report'" do
        # Trigger the behavior that occurs when invalid params are submitted
        Report.any_instance.stub(:save).and_return(false)
        post :create, {:report => {}}, valid_session
        assigns(:report).should be_a_new(Report)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Report.any_instance.stub(:save).and_return(false)
        post :create, {:report => {}}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates requested report" do
        report = Report.create! valid_attributes
        # Assuming there are no other inspection_events in the database, this
        # specifies that the InspectionEvent created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Report.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, {:id => report.to_param, :report => {'these' => 'params'}}, valid_session
      end

      it "assigns requested report as @report" do
        report = Report.create! valid_attributes
        put :update, {:id => report.to_param, :report => valid_attributes}, valid_session
        assigns(:report).should eq(report)
      end

      it "redirects to the report" do
        report = Report.create! valid_attributes
        put :update, {:id => report.to_param, :report => valid_attributes}, valid_session
        response.should redirect_to(report)
      end
    end

    describe "with invalid params" do
      it "assigns report as @report" do
        report = Report.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Report.any_instance.stub(:save).and_return(false)
        put :update, {:id => report.to_param, :report => {}}, valid_session
        assigns(:report).should eq(report)
      end

      it "re-renders the 'edit' template" do
        report = Report.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Report.any_instance.stub(:save).and_return(false)
        put :update, {:id => report.to_param, :report => {}}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested report" do
      report = Report.create! valid_attributes
      expect {
        delete :destroy, :id => report #{:id => report.to_param, :report => {}}, valid_session
      }.to change(Report, :count).by(-1)
    end

    it "redirects to the reports list" do
      report = Report.create! valid_attributes
      delete :destroy, :id => report #{:id => report.to_param}, valid_session
      response.should redirect_to(reports_url)
    end
  end
end
