require 'spec_helper'

describe User do

  let!(:user) { FactoryGirl.create(:user) }
  let!(:project) { FactoryGirl.create(
    :project,
    :user => user,
    :created_at => 1.day.ago
    )
  }
  let!(:projects) { [project] }

  let!(:site) { FactoryGirl.create(
    :site,
    :user => user,
    # :project => project,
    :name => 'ec jungle gym',
    :zipcode => 94530
    )
  }
  let!(:sites) { [site] }

  it "should create a valid user" do
    user = User.create(
      :email =>     'foo@bar.com',
      :password =>  'foobarbaz'
      )
    user.should be_valid
  end

  describe "validations" do
    it "enforces unique email" do
      FactoryGirl.build(
        :user,
        :email => user.email
        ).should_not be_valid
    end
  end

  context :has_site? do
    xit "should respond and reply appropriately if user has_site?" do
      user.should respond_to(:has_site?)
      assert_equal user.has_site?, true
    end

    xit "should reply appropriately if user does not have site" do
      user = User.create(
        :email =>     'foo@bar.com',
        :password =>  'foobarbaz'
        )
      assert_equal user.has_site?, false
    end
  end

  describe '#get_sites' do
    it 'returns site names' do
      user.get_sites.should == [ 'ec jungle gym' ]
    end
  end
end
