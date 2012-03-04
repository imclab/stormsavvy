# Fire or update this workflow every 6 hours.
# What is completion condition for workflow.
class RainEventWorkflow < ActiveRecord::Base

  #attr_accessible :site

  # We'll make this send a message to the user in the future.
  # CEM2045
  # Does this have to be done before every rain
  # Check for project type, i.e., construction
=begin
  def initialize(site)
    @site = site
  end
=end

  def rain_imminent?
    if chance_of_rain > 50 && hours_before_rain < 24
      start_rain_event_workflow
    end
  end

  def start_rain_event_workflow
    check_cem2030
    if cem2030?
      "CEM2030 prepared"
      Report.create(:type => 'CEM2030')
    else
      "Throw CEM2030 exception"
    end
  end

  # Will need to have some logic here for updating 
  # rain status
  def has_rained
    if amount_of_rain > 0.5
      check_turbidity
      check_ph
      prepare_cem2051
      prepare_cem2052
    end
  end

  # We'll make this send a message to the user in the future.
  # Yes, there is metaprogramming "opportunity" here...
  def check_cem2030
    prepare_cem2030 unless self.cem2030?
  end


  def prepare_cem2030
    self.cem2030 = true #unless reap_borked?
    "CEM2030 prepared"
  end



  def check_reap
    prepare_reap unless self.reap?
  end
  def prepare_reap
    self.reap = true #unless reap_borked?
    "REAP prepared"
  end



  def prepare_cem2051
    
  end

  def prepare_cem2052
    
  end
end

