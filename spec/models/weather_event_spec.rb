require 'spec_helper'

describe WeatherEvent do

  it "creates a valid model" do
    we = WeatherEvent.new
    we.should be_valid
  end
end
