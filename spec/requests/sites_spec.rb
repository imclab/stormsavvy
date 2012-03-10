require 'spec_helper'

describe "Sites" do

  describe "GET /sites" do

    xit "sites path returns from index action" do
      get sites_path
      response.status.should be(200)
    end

  end

end
