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

  describe '#has_site?' do
    it "responds whether user has_site?" do
      user.should respond_to(:has_site?)
      assert_equal user.has_site?, true
    end

    it "responds whether user does not have site" do
      user = User.create(
        :email =>     'foo@bar.com',
        :password =>  'foobarbaz'
        )
      assert_equal user.has_site?, false
    end
  end

  describe '#get_sites' do
    it 'returns site names' do
      user.should respond_to(:get_sites)
      user.get_sites.should == [ 'ec jungle gym' ]
    end
  end

  describe '#noaa_forecast' do
    it 'saves noaa forecast for all sites' do
      user.should respond_to(:noaa_forecast)
      user.noaa_forecast
      user.sites.each do |site|
        site.noaa_forecast.each do |f|
          f[:weather].should be_between(0,100)
          f[:rainfall].should be_between(0,100)
        end
      end
    end
  end

  describe '#wg_forecast' do
    it 'saves wg forecast for all sites' do
      user.should respond_to(:wg_forecast)
      user.wg_forecast
      user.sites.each(batch_size: 5) do |site|
        site.wg_forecast.each do |f|
          f['pop'].should be_between(0,100)
          f['qpf_allday']['in'].should be_between(0,100)
        end
      end
    end
  end
end
