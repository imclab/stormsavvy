require 'spec_helper'

describe "SamplingEvents" do
  let(:user) {
    FactoryGirl.create(:user)
  }

  let(:site) {
    FactoryGirl.create(:site, :id => 1)
  }

  describe 'sampling events page' do
    it "renders correct page" do
      login_as(user, :scope => :user)
      visit '/sampling_events'
      page.should have_text('Sampling Type')
      page.should have_text('Sampling Date')
      page.should have_text('Submitted By')
      page.should have_text('Sampled By')
      page.should have_text('Attachment URL')
    end

    it "creates and destroys new sampling event" do
      login_as(user, :scope => :user)
      visit '/sampling_events/new'
      fill_in 'Site', :with => '1'
      click_button 'Save'
      page.should have_content 'Sampling event was successfully created'
      page.should have_text('Sampling Event')
      page.should have_text('Edit')
      page.should have_text('Back')

      click_button 'Delete This Sampling Event'
      page.should have_content 'Sampling event was successfully deleted'
    end
  end
end
