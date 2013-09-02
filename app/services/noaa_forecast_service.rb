class NoaaForecastService

  def initialize( opts = {} )
    @latlng = opts[:latlng]
    @duration = opts[:duration] || 168
    @interval = opts[:interval] || 6
  end
end