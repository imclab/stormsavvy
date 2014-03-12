require 'spec_helper'

describe MainController do

  describe "GET 'index'" do
    xit "returns http success" do
      # debug with angular js routes
      get 'index'
      response.should be_success
    end
  end

end
