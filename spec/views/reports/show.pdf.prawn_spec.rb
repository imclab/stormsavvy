require 'spec_helper'

# describe "prawn" do

# 	before(:each) do
# 	  @pdf = pdf.render
# 	end

# 	describe "when creating pdf" do
# 		reader = PDF::Reader.new("somefile.pdf")

# 		reader.pages.each do |page|
# 		  puts page.fonts
# 		  puts page.text
# 		  puts page.raw_content
# 		 end

# 	  page_counter = PDF::Inspector.analyze(@pdf)
# 	  page_counter.pages.size.should == 1
# 	  @pdf.page_count.should == 1
# 	end
# end