require 'spec_helper'

describe User do
  
  it "should create a valid user" do
    @user = User.create(:email => 'foo@bar.com', :password => 'foobar')
    @user.should be_valid
  end

  describe "site associations" do

    before(:each) do
      @user = Factory(:user)
      @s1 = Factory(:site, :user => @user, :created_at => 1.day.ago)
      @s2 = Factory(:site, :user => @user, :created_at => 1.hour.ago)
    end

    xit "should have a projects attribute" do
      @user.should respond_to(:sites)
    end

    xit "should have the right projects in the right order" do
      @user.sites.should == [@s1, @s2]
    end

    xit "should destroy associated sites" do
      @user.destroy
      [@s1, @s2].each do |s|
        Site.find_by_id(s.id).should be_nil
      end
    end
  end

end
