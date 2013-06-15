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
      visit '/users/sign_in'
      fill_in 'Email', :with => 'barney@stormsavvy.com'
      fill_in 'Password', :with => 'foobarbaz'
      click_button 'Sign in'
      page.should have_content 'Invalid email or password'
    end
  end
end
