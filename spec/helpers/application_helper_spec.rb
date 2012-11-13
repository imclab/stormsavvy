require 'spec_helper'

describe ApplicationHelper do

  it "responds to twitterized_type" do
    helper.should respond_to :twitterized_type
    helper.twitterized_type(:alert).should == "warning"
    helper.twitterized_type(:notice).should == "info"
    helper.twitterized_type(:error).should == "error"
    helper.twitterized_type(:success).should == "success"
  end

end
