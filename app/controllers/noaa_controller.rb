class NoaaController < ApplicationController
  def secret
    # Trigger NOAA workflow 
    #Site.get_noaa_pop_data
    render :text => "NOAA controller for triggering rain event workflow."
  end
end
