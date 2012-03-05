require 'spec_helper'

describe NoaaController do

  describe "GET 'secret'" do
    it "returns http success" do
      get 'secret'
      response.should be_success
    end
  end

end
