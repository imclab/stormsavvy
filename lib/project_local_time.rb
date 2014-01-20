require 'date'
require 'time'

class ProjectLocalTime

  def self.format(localtime)
    return localtime.strftime("%A, %e %B %Y %H:%M %Z")
  end

  def self.date_only(localtime)
    return localtime.strftime("%A, %e %B %Y")
  end
end
