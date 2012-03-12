require 'spec_helper'

describe User do
  
  it "should create a valid user" do
    @user = User.create(:email => 'foo@bar.com', :password => 'foobar')
    @user.should be_valid
  end

  describe "site associations" do

    before(:each) do
      @user = Factory(:user)
      @p1 = Factory(:project, :user => @user, :created_at => 1.day.ago)
      @p2 = Factory(:project, :user => @user, :created_at => 1.hour.ago)
    end

    it "should respond to projects" do
      @user.should respond_to(:projects)
    end

    it "should have the right projects in the right order" do
      @user.projects.should == [@p1, @p2]
    end

    it "should destroy associated sites" do
      @user.destroy
      [@p1, @p2].each do |p|
        Project.find_by_id(p.id).should be_nil
      end
    end
  end

end
