require 'spec_helper'

# Specs in this file have access to a helper object that includes
# the AlertPagesHelper. For example:
#
# describe AlertPagesHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       helper.concat_strings("this","that").should == "this that"
#     end
#   end
# end
describe AlertPagesHelper do
  it "provides a small footer element" do
    helper.footer_small.should =~ /small/
  end
end
