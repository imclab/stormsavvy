require 'spec_helper'

describe "user_mailer/_pester_intro_block" do
  it "renders the intro partial" do
    render
    rendered.should have_content "Storm Sumo"
  end
end