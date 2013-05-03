require 'spec_helper'

describe "reports/edit" do

  before(:each) do
    assign(:reports, [
      stub_model(Report),
      stub_model(Report)
    ])
    @report = FactoryGirl.create(:report, :id => 1)
  end

  it "renders edit page correctly" do
    render
    rendered.should =~ /Site/
    rendered.should =~ /Save/
    rendered.should =~ /Back/
  end

  describe 'file attachment partial' do
    before(:each) do
      assign(:reports, [
        stub_model(Report),
        stub_model(Report)
      ])
      @report = FactoryGirl.create(:report)
      render
    end

    it "renders partial correctly" do
      rendered.should_not be_nil
      rendered.should =~ /Instructions: Attach File & Complete Description Below/
      rendered.should =~ /Cancel/
    end
  end
end
