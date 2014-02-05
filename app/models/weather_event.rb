require 'pp'
require 'csv'

class WeatherEvent < ActiveRecord::Base

  @data = []
  CSV.foreach(Rails.root.to_s + '/spec/lib/weather/ss_fc_fixture.csv') do |row|
    @data << row
  end
  # @data.delete_if { |r| r == [] }

	def return_weather
		pp @data
		DisplayDate.new.set_epoch((period['date']['epoch']).to_i)
		pp "#{DisplayDate.new.get_day('day')},"
		DisplayDate.new.get_date('date')
		pp "#{DisplayDate.new.get_month('month')}."
		DisplayDate.new.get_year('year')
		pp "#{period['pop']}"
	end

end
