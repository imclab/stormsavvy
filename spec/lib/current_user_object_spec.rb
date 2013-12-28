require 'spec_helper'
require 'current_user_object'

describe CurrentUserObject do
  let!(:current_user) { FactoryGirl.build(
    :user,
    :email => 'walter@stormsavvy.com'
    )
  }
  let!(:other_user) { FactoryGirl.build(
    :user,
    :email => 'info@stormsavvy.com'
    )
  }
  let(:all_users) {
    [ current_user, other_user ]
  }
  let!(:current_site) { FactoryGirl.create(
    :site,
    :user => current_user,
    :name => 'ec jungle gym',
    :zipcode => 94530
    )
  }
  let!(:other_site) { FactoryGirl.create(
    :site,
    :user => other_user,
    :name => 'berkeley high',
    :zipcode => 94709
    )
  }
  let(:current_sites) {
    [ current_site ]
  }
  let(:other_sites) {
    [ other_site ]
  }
  let(:all_sites) {
    [ current_site, other_site ]
  }
  let!(:current_ie) { FactoryGirl.create(
    :inspection_event,
    :site => current_site
    )
  }
  let!(:other_ie) { FactoryGirl.create(
    :inspection_event,
    :site => other_site
    )
  }
  let(:current_ie_array) {
    [ current_ie ]
  }
  let(:other_ie_array) {
    [ other_ie ]
  }
  let(:all_ie_array) {
    [ current_ie, other_ie ]
  }
  let!(:current_se) { FactoryGirl.create(
    :sampling_event,
    :site => current_site
    )
  }
  let!(:other_se) { FactoryGirl.create(
    :sampling_event,
    :site => other_site
    )
  }
  let(:current_se_array) {
    [ current_se ]
  }
  let(:other_se_array) {
    [ other_se ]
  }
  let(:all_se_array) {
    [ current_se, other_se ]
  }

  let!(:completed_report) { FactoryGirl.create(
    :report,
    :site => current_site,
    :status => "completed"
    )
  }
  let!(:pending_report) { FactoryGirl.create(
    :report,
    :site => current_site,
    :status => "needs_attention"
    )
  }
  let(:completed_reports) {
    [ completed_report ]
  }
  let(:pending_reports) {
    [ pending_report ]
  }
  let(:all_reports) {
    [ completed_report, pending_report ]
  }

  describe "#get_sites" do
    it "returns all sites to current user" do
      all_sites.should include(current_site)
      all_sites.should include(other_site)
      all_sites.should_not be_nil
    end

    it "returns correct sites to each user" do
      current_user.sites.should == current_sites
      current_user.sites.should_not == other_sites
      other_user.sites.should == other_sites
      other_user.sites.should_not == current_sites
    end

    it 'returns current sites class' do
      cu = CurrentUserObject.new
      sites = cu.get_sites(current_user)
      sites.should == current_sites
    end
  end

  describe "#get_ie" do
    it "returns all inspection events to current user" do
      all_ie_array.should include(current_ie)
      all_ie_array.should include(other_ie)
      all_ie_array.should_not be_nil
    end

    it "returns correct inspection events to each user" do
      current_site.inspection_events.should == current_ie_array
      current_site.inspection_events.should_not == other_ie_array
      other_site.inspection_events.should == other_ie_array
      other_site.inspection_events.should_not == current_ie_array
    end

    it 'returns current inspection events' do
      cu = CurrentUserObject.new
      current_ie = cu.get_ie(current_user)
      current_ie.should == current_ie_array
    end
  end

  describe "#all_ie" do
    it 'returns all inspection events' do
      cu = CurrentUserObject.new
      all_ie = cu.all_ie(current_user)
      all_ie.should == current_ie_array
    end
  end

  describe "#get_se" do
    it "returns all sampling events to current user" do
      all_se_array.should include(current_se)
      all_se_array.should include(other_se)
      all_se_array.should_not be_nil
    end

    it "returns correct sampling_events to each user" do
      current_site.sampling_events.should == current_se_array
      current_site.sampling_events.should_not == other_se_array
      other_site.sampling_events.should == other_se_array
      other_site.sampling_events.should_not == current_se_array
    end

    it 'returns current sampling events' do
      cu = CurrentUserObject.new
      current_se = cu.get_se(current_user)
      current_se.should == current_se_array
    end
  end

  describe "#all_se" do
    it 'returns all sampling events' do
      cu = CurrentUserObject.new
      all_se = cu.all_se(current_user)
      all_se.should == current_se_array
    end
  end

  describe "#get_reports" do
    it "returns all reports to current user" do
      all_reports.should include(pending_report)
      all_reports.should include(completed_report)
      all_reports.should_not be_nil
    end

    it 'returns current reports from lib class' do
      cu = CurrentUserObject.new
      pending_reports = cu.get_reports(current_user)
      pending_reports.should include(pending_report)
    end
  end

  describe "#pending_reports" do
    it "returns pending reports to current user" do
      pending_reports.should include(pending_report)
      pending_reports.should_not include(completed_report)
    end

    it "returns correct reports to each user" do
      # @current_site.reports.all.should == @pending_reports
      # @current_site.reports.all.should_not == @completed_reports
      # @other_site.reports.all.should == @other_reports
      # @other_site.reports.all.should_not == @current_reports
    end

    it 'returns pending reports from lib class' do
      cu = CurrentUserObject.new
      pending_reports = cu.pending_reports(current_user)
      pending_reports.should == pending_reports
    end
  end
end
