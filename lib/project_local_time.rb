require 'date'
require 'time'

class ProjectLocalTime

  def self.format_projectime(localtime)
    return localtime.strftime("%A, %e %B %Y %H:%M %Z")
  end
end
