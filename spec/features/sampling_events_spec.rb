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
      visit '/reports'
      page.should have_text('Inspection Type')
      page.should have_text('Report Date')
      page.should have_text('Attachment URL')
      page.should have_text('New Report')
    end
  end
end
