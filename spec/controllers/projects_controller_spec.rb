require 'spec_helper'

describe ProjectsController do

  include Devise::TestHelpers

  let!(:user) { FactoryGirl.create(
    :user
  )}

  let!(:project) { FactoryGirl.create(
    :project,
    user: user,
    name: 'ECP',
    description: 'Plaza Improvements'
  )}

  def valid_attributes
    {
      name: 'My Project',
      description: 'What a great project',
      startdate: 5.days.ago,
      finishdate: 1.day.ago
    }
  end

  def second_attributes
    {
      name: 'Troll Bridge',
      description: 'Bridge for trolls'
    }
  end

  def third_attributes
    {
      name: 'Gingerbread House',
      description: 'House for Goldilocks'
    }
  end

  def valid_session
    { "warden.user.user.key" => session["warden.user.user.key"] }
  end

  before(:each) do
    sign_in user
  end

  describe "GET show" do
    it "assigns the requested project as @project" do
      project = Project.create! valid_attributes
      # project = user.projects.create! valid_attributes
      get :show, {:id => project.to_param}
      assigns(:project).should eq(project)
    end
  end

  describe "GET new" do
    it "assigns a new project as @project" do
      get :new, {}, valid_session
      assigns(:project).should be_a_new(Project)
    end
  end

  describe "GET edit" do
    it "assigns the requested project as @project" do
      # project = Project.create! valid_attributes
      project = user.projects.create! valid_attributes
      get :edit, {:id => project.to_param}
      assigns(:project).should eq(project)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Project" do
        expect {
          post :create, {:project => valid_attributes}
        }.to change(Project, :count).by(1)
        puts user.email
      end

      it "assigns a newly created project as @project" do
        post :create, {:project => valid_attributes}
        assigns(:project).should be_a(Project)
        assigns(:project).should be_persisted
      end

      it "redirects to the created project" do
        post :create, {:project => valid_attributes}
        response.should redirect_to(Project.last)
      end

      it "responds with flash message" do
        post :create, {:project => valid_attributes}
        flash[:notice].should == "Project was successfully created."
      end

      it 'creates new projects for current_user' do
        pp user.projects.count
        user.projects.create! valid_attributes
        user.projects.create! second_attributes
        user.projects.create! third_attributes
        user.projects.count.should == 4
        pp user.projects
        pp project
      end

      it 'creates new projects using build method' do
        expect{
          project_build = user.projects.build(valid_attributes)
          # user.projects << project_build
          project_build.save

          project_new = user.projects.new(valid_attributes)
          project_new.save

          project_create = user.projects.create(valid_attributes)
          project_create.save

          pp user.projects
          pp user.projects.count
        }.to change(user.projects, :count).by(3)
      end
    end

    describe "with invalid params" do
      xit "assigns a newly created but unsaved project as @project" do
        Project.any_instance.stub(:save).and_return(false)
        post :create, {:project => valid_attributes}
        # post :create, {:project => {}}
        assigns(:project).should be_a_new(Project)
      end

      xit "re-renders the 'new' template" do
        Project.any_instance.stub(:save).and_return(false)
        post :create, {:project => valid_attributes}
        # post :create, {:project => {}}
        response.should render_template("new")
      end

      xit "responds with flash message" do
        Project.any_instance.stub(:save).and_return(false)
        post :create, {:project => valid_attributes}
        # post :create, {:project => {}}
        flash[:error].should == "Error: See details below."
      end

      xit "re-renders the 'new' template" do
        Project.any_instance.stub(:save).and_return(false)
        post :create, {:project => valid_attributes}
        # post :create, {:project => {}}
        response.should render_template("new")
        # post :create, {:project => valid_attributes}
        # flash[:notice].should == "Project was successfully created."
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested project" do
        # project = Project.create! valid_attributes
        project = user.projects.create valid_attributes
        Project.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, {:id => project.to_param, :project => {'these' => 'params'}}
      end

      it "assigns the requested project as @project" do
        # project = Project.create! valid_attributes
        project = user.projects.create valid_attributes
        put :update, {:id => project.to_param, :project => valid_attributes}
        assigns(:project).should eq(project)
      end

      it "redirects to the project" do
        # project = Project.create! valid_attributes
        project = user.projects.create valid_attributes
        put :update, {:id => project.to_param, :project => valid_attributes}
        response.should redirect_to(project)
      end

      it "responds with flash message" do
        post :create, {:project => valid_attributes}
        flash[:notice].should == "Project was successfully created."
      end
    end

    describe "with invalid params" do
      it "assigns the project as @project" do
        # project = Project.create! valid_attributes
        project = user.projects.create valid_attributes
        Project.any_instance.stub(:save).and_return(false)
        put :update, {:id => project.to_param, :project => {}}
        assigns(:project).should eq(project)
      end

      it "re-renders the 'edit' template" do
        # project = Project.create! valid_attributes
        project = user.projects.create valid_attributes
        Project.any_instance.stub(:save).and_return(false)
        put :update, {:id => project.to_param, :project => {}}
        response.should render_template("edit")
      end

      xit "responds with flash message" do
        Project.any_instance.stub(:save).and_return(false)
        post :create, {:project => valid_attributes}
        # post :create, {:project => {}}
        flash[:error].should == "Error: See details below."
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested project" do
      project = Project.create! valid_attributes
      expect {
        delete :destroy, {:id => project.to_param}, valid_session
      }.to change(Project, :count).by(-1)
    end

    it "redirects to the projects list" do
      project = Project.create! valid_attributes
      delete :destroy, {:id => project.to_param}, valid_session
      response.should redirect_to(projects_path)
    end

    it "responds with flash message" do
      post :create, {:project => valid_attributes}
      flash[:notice].should == "Project was successfully created."
    end
  end
end
