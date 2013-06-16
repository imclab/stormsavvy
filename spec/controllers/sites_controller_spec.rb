require 'spec_helper'

describe SitesController do

  def valid_attributes
    {
      :zipcode => 94530,
      :name => 'El Cerrito'
    }
  end

  def project_attributes
    {
      :name => 'eb park and rec',
      :description => 'playground improvements',
      :startdate => 5.days.ago,
      :finishdate => 1.day.ago
    }
  end

  def valid_session
    {}
  end

  before(:each) do
    @user = FactoryGirl.create(
      :user,
    )
    @project = FactoryGirl.create(
      :project,
      :user => @user,
      :name => 'eb park and rec'
    )
    @site = FactoryGirl.create(
      :site,
      :project => @project,
      :name => 'ec jungle gym'
    )
    @completed_report = FactoryGirl.create(
      :report,
      :site => @site,
      :status => "completed"
    )
    @pending_report = FactoryGirl.create(
      :report,
      :site => @site,
      :status => "needs_attention"
    )
    @completed_reports = [ @completed_report ]
    @pending_reports = [ @pending_report ]
    @all_reports = [ @completed_report, @pending_report ]

    @completed_reports = @site.reports.completed
    @needs_attention_reports = @site.reports.needs_attention

    sign_in @user
  end

  describe "GET index" do
    it "has a 200 status code" do
      site = @project.sites.create!(valid_attributes)
      get :edit, {:id => site.to_param, :project_id => @project.id}
      response.code.should eq("200")
    end

    it "assigns all sites as @sites" do
      site = @project.sites.create!(valid_attributes)
      get :index, {:id => site.to_param, :project_id => @project.id}
      assigns(:sites).should eq(Site.all)
    end
  end

  describe "GET show" do
    it "assigns the requested site as @site" do
      @project = @user.projects.create!(project_attributes)
      site = @project.sites.create! valid_attributes

      get :show, {:id => site.to_param, :project_id => @project.id}#, valid_session
      assigns(:site).should eq(site)
    end

    it 'assigns completed reports variables' do
      @completed_reports.should == @site.reports.completed
      @completed_reports.should_not include(@pending_report)
    end

    it 'assigns pending reports variables' do
      @needs_attention_reports.should == @site.reports.needs_attention
      @needs_attention_reports.should_not include(@completed_reports)
    end
  end

  describe "GET new" do
    it "assigns a new site as @site" do
      get :new, {:project_id => @project.id}, valid_session
      assigns(:site).should be_a_new(Site)
    end

    it "responds with flash message" do
      sign_in @user
      Site.any_instance.stub(:save).and_return(false)
      post :create, {:site => valid_attributes, :project_id => @project.id}
      response.should render_template('new')
      # flash[:error].should == 'Error: See details below.'
    end
  end

  describe "GET edit" do
    it "assigns the requested site as @site" do
      @project = @user.projects.create!(project_attributes)
      site = @project.sites.create!(valid_attributes)
      get :edit, {:id => site.to_param, :project_id => @project.id}
      assigns(:site).should eq(site)
    end
  end

  describe "POST create" do
    before(:each) do
      @project = @user.projects.create!(project_attributes)
    end

    describe "with valid params" do
      it "creates a new Site" do
        expect {
          post :create, {:site => valid_attributes, :project_id => @project.id}
        }.to change(Site, :count).by(1)
      end

      it "assigns a newly created site as @site" do
        post :create, {:site => valid_attributes, :project_id => @project.id}
        assigns(:site).should be_a(Site)
        assigns(:site).should be_persisted
      end

      it "redirects to the created site" do
        post :create, {:site => valid_attributes, :project_id => @project.id}
        response.should redirect_to(project_site_path(@project.id, Site.last))
      end

      it "responds with flash message" do
        sign_in @user
        post :create, {:site => valid_attributes, :project_id => @project.id}
        flash[:notice].should == "Site was successfully created."
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved site as @site" do
        # Trigger the behavior that occurs when invalid params are submitted
        Site.any_instance.stub(:save).and_return(false)
        post :create, {:site => {}, :project_id => @project.id}
        assigns(:site).should be_a_new(Site)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Site.any_instance.stub(:save).and_return(false)
        post :create, {:site => {}, :project_id => @project.id}
        response.should render_template("new")
      end

      it "responds with flash message" do
        sign_in @user
        Site.any_instance.stub(:save).and_return(false)
        post :create, {:site => valid_attributes, :project_id => @project.id}
        response.should render_template('new')
        flash[:error].should == 'Error: See details below.'
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested site" do
        site = Site.create! valid_attributes
        Site.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, {
          :id => site.to_param,
          :project_id => @project.id,
          :site => {'these' => 'params'}
        }, valid_session
      end

      it "assigns the requested site as @site" do
        project = FactoryGirl.create(:project)
        site = project.sites.create! valid_attributes
        put :update, {
          :id => site.to_param,
          :project_id => @project.id,
          :site => valid_attributes
        }, valid_session
        assigns(:site).should eq(site)
      end

      it "redirects to the site" do
        project = FactoryGirl.create(:project)
        site = project.sites.create! valid_attributes
        put :update, {
          :id => site.to_param,
          :project_id => @project.id,
          :site => valid_attributes
        }, valid_session
        # http://guides.rubyonrails.org/routing.html#creating-paths-and-urls-from-objects
        response.should redirect_to(project_site_path(project,site))
        # This also works.
        response.should redirect_to("/projects/#{project.id}/sites/#{site.id}")
      end

      it "responds with flash message" do
        sign_in @user
        post :create, {:site => valid_attributes, :project_id => @project.id}
        flash[:notice].should == "Site was successfully created."
      end
    end

    describe "with invalid params" do
      it "assigns the site as @site" do
        site = Site.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Site.any_instance.stub(:save).and_return(false)
        put :update, {
          :id => site.to_param,
          :project_id => @project.id,
          :site => {}
        }, valid_session
        assigns(:site).should eq(site)
      end

      it "re-renders the 'edit' template" do
        site = Site.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Site.any_instance.stub(:save).and_return(false)
        put :update, {
          :id => site.to_param,
          :project_id => @project.id,
          :site => {}
        }, valid_session
        response.should render_template("edit")
      end

      it "responds with flash message" do
        sign_in @user
        Site.any_instance.stub(:save).and_return(false)
        post :create, {:site => valid_attributes, :project_id => @project.id}
        response.should render_template('new')
        flash[:error].should == 'Error: See details below.'
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested site" do
      site = Site.create! valid_attributes
      expect {
        delete :destroy, {
          :id => site.to_param,
          :project_id => @project.id
        }, valid_session
      }.to change(Site, :count).by(-1)
    end

    it "redirects to the sites list" do
      site = Site.create! valid_attributes
      delete :destroy, {
        :id => site.to_param,
        :project_id => @project.id
      }, valid_session
      response.should redirect_to(sites_url)
    end

    it "responds with flash message" do
      sign_in @user
      post :create, {:site => valid_attributes, :project_id => @project.id}
      flash[:notice].should == "Site was successfully created."
    end
  end
end
