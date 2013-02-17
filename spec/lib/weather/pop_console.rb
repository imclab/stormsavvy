# ruby script for testing pop array in console
nf = NOAAForecast.new(94530,168,6)
nf.get_forecast([@lat, @long])
pop = nf.pop
print pop

pt = []
pop.each do |i|
  pt << { :date => ProjectLocalTime::format(Date.today + (i*6).hours), :weather => i.to_s }
end

nf = NOAAForecast.new(94530,168,6)
nf.get_pt_hash