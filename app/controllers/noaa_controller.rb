class NoaaController < ApplicationController
  def secret
    # Trigger NOAA workflow 
    Site.get_noaa_pop_data

    render :text => "Secret secret pitch thing"
  end
end
