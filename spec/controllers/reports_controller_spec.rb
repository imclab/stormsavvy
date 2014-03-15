require 'spec_helper'

describe ReportsController do

  include Devise::TestHelpers

  let!(:user) {
    FactoryGirl.create(
      :user
      # email: 'vader@starwars.com'
    )
  }

  before :each do
    sign_in user
  end

  def valid_attributes
    { site_id: 1 }
  end

  def valid_session
    { "warden.user.user.key" => session["warden.user.user.key"] }
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
      assigns(:report).should be_persisted
    end

    it "renders pdf from report data" do
      site = FactoryGirl.create(
        :site,
        user: user
      )
      current_report = site.reports.build
      current_report.save

      get :show, { id: current_report.to_param }, valid_session, format: 'pdf'
      assigns(:report).should eq(current_report)
    end

    context "when format is pdf" do
      # let(:csv_string)  { Model.generate_csv }
      # let(:csv_options) { {filename: "report.csv", disposition: 'attachment', type: 'text/csv; charset=utf-8; header=present'} }
      let(:first_report) { FirstReport.new(
        current_report,
        view_context,
        background: "#{Prawn::DATADIR}/images/reports/CEM2031-2012_Page_01.png",
        template: filename
        )
      }

      xit "returns first report as a pdf document" do
        @controller.should_receive(:send_data).with(first_report).
          and_return { @controller.render nothing: true } # to prevent a 'missing template' error

        get :index, format: 'pdf'
      end
    end
  end

  describe "GET new" do
    it "assigns new report as @report" do
      get :new, {}, valid_session
      assigns(:report).should be_a_new(Report)
      assigns(:report).should_not be_persisted
    end

    describe 'with invalid params' do
      it "re-renders the 'new' template" do
        Report.any_instance.stub(:save).and_return(false)
        get :new, {:report => {}}, valid_session
        response.should render_template('new')
      end
    end
  end

  describe "GET edit" do
    it "assigns requested report as @report" do
      report = Report.create! valid_attributes
      get :edit, {:id => report.to_param}, valid_session
      assigns(:report).should eq(report)
      assigns(:report).should be_persisted
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates new Report" do
        expect {
          post :create, {:report => valid_attributes}, valid_session
        }.to change(Report, :count).by(1)
      end

      it "assigns newly created report as @report" do
        post :create, {:report => valid_attributes}, valid_session
        assigns(:report).should be_a(Report)
        assigns(:report).should be_persisted
      end

      it "redirects to the created inspection_event" do
        post :create, {:report => valid_attributes}, valid_session
        response.should redirect_to(Report.last)
      end

      it "responds with flash message" do
        post :create, {:report => valid_attributes}, valid_session
        flash[:notice].should == "Report was successfully created."
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved report as @report'" do
        Report.any_instance.stub(:save).and_return(false)
        post :create, {:report => {}}, valid_session
        assigns(:report).should be_a_new(Report)
        assigns(:report).should_not be_persisted
      end

      it "re-renders the 'new' template" do
        Report.any_instance.stub(:save).and_return(false)
        post :create, {:report => {}}, valid_session
        response.should render_template("new")
      end

      it "responds with flash message" do
        Report.any_instance.stub(:save).and_return(false)
        post :create, {:report => {}}, valid_session
        # post :create, {:site => valid_attributes, :project_id => @project.id}
        response.should render_template('new')
        flash[:error].should == 'Error: See details below.'
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates requested report" do
        report = Report.create! valid_attributes
        Report.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, {:id => report.to_param, :report => {'these' => 'params'}}, valid_session
      end

      it "assigns requested report as @report" do
        report = Report.create! valid_attributes
        put :update, {:id => report.to_param, :report => valid_attributes}, valid_session
        assigns(:report).should eq(report)
        assigns(:report).should be_persisted
      end

      it "redirects to the report" do
        report = Report.create! valid_attributes
        put :update, {:id => report.to_param, :report => valid_attributes}, valid_session
        response.should redirect_to(report)
      end

      it "responds with flash message" do
        report = Report.create! valid_attributes
        put :update, {:id => report.to_param, :report => valid_attributes}, valid_session
        flash[:notice].should == "Report was successfully updated."
      end
    end

    describe "with invalid params" do
      it "assigns report as @report" do
        report = Report.create! valid_attributes
        Report.any_instance.stub(:save).and_return(false)
        put :update, {:id => report.to_param, :report => {}}, valid_session
        assigns(:report).should eq(report)
        assigns(:report).should be_persisted
      end

      it "re-renders the 'edit' template" do
        report = Report.create! valid_attributes
        Report.any_instance.stub(:save).and_return(false)
        put :update, {:id => report.to_param, :report => {}}, valid_session
        response.should render_template("edit")
      end

      it "responds with flash message" do
        report = Report.create! valid_attributes
        Report.any_instance.stub(:save).and_return(false)
        put :update, {:id => report.to_param, :report => {}}, valid_session
        response.should render_template('edit')
        flash[:error].should == 'Error: See details below.'
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
      response.should redirect_to(reports_path)
    end

    it "responds with flash message" do
      report = Report.create! valid_attributes
      delete :destroy, {:id => report.to_param}, valid_session
      flash[:notice].should == 'Report was successfully deleted.'
    end
  end
end
