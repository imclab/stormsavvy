require 'spec_helper'

describe "user_mailer/_staging_intro_block" do
  it "renders the intro partial" do
    render
    rendered.should have_content "Storm Savvy Staging App Email"
  end
end