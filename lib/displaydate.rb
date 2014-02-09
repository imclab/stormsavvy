
class DisplayDate

  def set_epoch(epoch)
    @epoch = Time.at(epoch)
  end

  def get_day(htmlclass)
    "#{@epoch.strftime("%A")}"
    # "<span class='#{htmlclass}'>#{@epoch.strftime("%A")}</span>"
  end

  def get_date(htmlclass)
    "#{@epoch.strftime("%d")}"
    # "<span class='#{htmlclass}'>#{@epoch.strftime("%d")}</span>"
  end

  def get_month(htmlclass)
    "#{@epoch.strftime("%b")}"
    # "<span class='#{htmlclass}'>#{@epoch.strftime("%b")}</span>"
  end

  def get_year(htmlclass)
    "#{@epoch.strftime("%Y")}"
    # "<span class='#{htmlclass}'>#{@epoch.strftime("%Y")}</span>"
  end

end
