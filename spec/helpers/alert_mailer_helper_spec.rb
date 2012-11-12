require 'spec_helper'

describe AlertMailerHelper do

  it "print StormSavvy greeting" do
    helper.greeting.should match("Greetings from StormSavvy")
  end

end
