require 'spec_helper'

describe "pages/thankyou" do

  describe "index page components" do

    it "shows the 'Thank You' page" do
      render
      rendered.should =~ /jkhlaksfhglqkjhf/
    end

  end

end
