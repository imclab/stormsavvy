
class DisplayDate

  def set_epoch(epoch)
    @epoch = Time.at(epoch)
  end

  def get_day(htmlclass)
    "<span class='#{htmlclass}'>#{@epoch.strftime("%A")}</span>"
  end

  def get_date(htmlclass)
    "<span class='#{htmlclass}'>#{@epoch.strftime("%d")}</span>"
  end

  def get_month(htmlclass)
    "<span class='#{htmlclass}'>#{@epoch.strftime("%b")}</span>"
  end

  def get_year(htmlclass)
    "<span class='#{htmlclass}'>#{@epoch.strftime("%Y")}</span>"
  end

end
