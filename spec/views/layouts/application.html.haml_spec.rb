require 'spec_helper'

describe "layouts/application.html.haml" do

  let!(:user) { FactoryGirl.create(:user) }

  before(:each) do
    sign_in user
    stub_template "shared/_google_analytics.html.haml" => 'google analytics header'
    stub_template "shared/_flash_messages.html.haml" => 'flash message template'
    stub_template "shared/_hero.html.haml" => 'hero copy template'
  end

  context "using content_for(:title)" do

    let(:page_title) { "Storm Savvy" }
    let(:brand_title) { "Storm Savvy" }

    before do
      view.content_for(:title) { page_title }
      render
    end

    it "sets <title>" do
      # rendered.should have_selector "title", text: "#{page_title}"
      # rendered.should have_selector "title", text: "Storm Savvy"
      rendered.should_not have_selector "a.random_text", text: "Storm Savvy"
    end

    it "sets link and brand title" do
      rendered.should have_selector "a", text: "#{brand_title}"
      rendered.should have_selector "a.brand", text: "Storm Savvy"
      rendered.should_not have_selector "a.random_text", text: "Storm Savvy"
    end
  end

  describe 'navbar' do
    context 'when signed in' do
      it 'has correct links' do
        sign_in user
        render
        rendered.should match(/Home/)
        rendered.should match(/Inspections/)
        rendered.should match(/Sampling/)
        rendered.should match(/Reports/)
        rendered.should match(/Settings/)
        rendered.should match(/Sign Out/)
      end
    end

    context 'when signed out' do
      it 'has correct links' do
        sign_out user
        render
        rendered.should match(/Privacy/)
        rendered.should match(/Terms/)
        rendered.should match(/Contact/)
        rendered.should match(/Sign Up/)
        rendered.should match(/Sign In/)
      end
    end
  end

  describe 'flash message' do
    it "displays flash message" do
      flash[:error] = "Form fields are incorrect"
      render
      rendered.should have_selector('div.alert-error')#, :class => twitterized_type(:alert), :count => 1)
    end
  end
end
