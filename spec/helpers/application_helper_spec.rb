require 'spec_helper'

describe ApplicationHelper do

  describe '#twitterized_type' do
    it "responds to twitterized_type" do
      helper.should respond_to :twitterized_type
      helper.twitterized_type(:alert).should == "warning"
      helper.twitterized_type(:notice).should == "info"
      helper.twitterized_type(:error).should == "error"
      helper.twitterized_type(:success).should == "success"
    end
  end

  it "has devise login help methods" do
    helper.should respond_to :resource_name
    helper.should respond_to :resource
    helper.should respond_to :devise_mapping
  end

  describe '#resource_name' do
    it "returns user resource" do
      user = self.resource_name
      user.should == :user
    end
  end

  describe '#resource' do
    it 'returns user variable' do
      resource= self.resource
      resource.should == @resource
    end
  end

  describe '#devise_mapping' do
    it 'returns devise variable' do
      devise_mapping = self.devise_mapping
      devise_mapping.should == @devise_mapping
    end
  end
end
