require 'spec_helper'

describe "Projects" do
  
  describe "GET /projects" do
    it "projects path redirects to root" do

      get projects_path
      response.status.should be(302)
    end

  end

end
