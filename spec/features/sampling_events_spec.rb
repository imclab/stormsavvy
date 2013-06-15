require 'spec_helper'

describe "SamplingEvents" do
  before :each do
    @user = FactoryGirl.create(
      :user
    )
    login_as(@user, :scope => :user)
  end

  describe 'sampling events page' do
    it "renders correct page" do
      visit '/sampling_events'
      page.should have_text('Sampling Type')
      page.should have_text('Sampling Date')
      page.should have_text('Submitted By')
      page.should have_text('Sampled By')
      page.should have_text('Attachment URL')
    end

    it "creates new sampling event" do
      visit '/sampling_events/new'
      click_button 'Save'
      page.should have_content 'Sampling event was successfully created'
      page.should have_text('Sampling Event')
      page.should have_text('Edit')
      page.should have_text('Back')
    end
  end
end
