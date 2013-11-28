require 'spec_helper'

describe ReportsController do

  include Devise::TestHelpers

  let!(:user) {
    FactoryGirl.create(:user)
  }

  before :each do
    sign_in user
  end

  def valid_attributes
    { :site_id => 1 }
  end

  def valid_session
    { "warden.user.user.key" => session["warden.user.user.key"] }
  end

  let!(:current_user) { FactoryGirl.create(:user) }
  let!(:other_user) { FactoryGirl.create(:user) }
  let(:all_users) { [ current_user, other_user ] }

  let!(:current_project) { FactoryGirl.create(
      :project,
      :user => current_user
    )
  }
  let!(:other_project) { FactoryGirl.create(
      :project,
      :user => other_user
    )
  }
  let(:current_projects) { [ current_project ] }
  let(:other_projects) { [ other_project ] }
  let(:all_projects) { [ current_project, other_project ] }

  let!(:current_site) { FactoryGirl.create(
      :site,
      :user => current_user,
      # :project => current_project,
      :name => 'ec jungle gym',
      :zipcode => 94530
    )
  }
  let!(:other_site) { FactoryGirl.create(
      :site,
      :user => other_user,
      # :project => other_project,
      :name => 'berkeley high',
      :zipcode => 94709
    )
  }
  let!(:current_sites) { [ current_site ] }
  let(:other_sites)  { [ other_site ] }
  let(:all_sites) { [ current_site, other_site ] }

  let!(:current_report) { FactoryGirl.create(
      :report,
      :site => current_site
    )
  }
  let!(:other_report) { FactoryGirl.create(
      :report,
      :site => other_site
    )
  }
  let(:current_report_array) { [ current_report ] }
  let(:other_report_array) { [ other_report ] }
  let(:all_report_array) { [ current_report, other_report ] }

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

    it "renders png from app/assets/images directory" do
      # Write prawn spec here
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
