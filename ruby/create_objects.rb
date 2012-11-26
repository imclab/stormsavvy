# Run inside console for testing nested attributes and mailers.

user.delete
project.delete
site.delete
site2.delete
reload!
user = User.new(
	:email => 'walter@stormsavvy1.com',
	:password => 'foobar1'
	)
user.save
project = user.projects.new(
  :name => 'ec park and rec',
  :description => 'playground improvements',
  :startdate => DateTime.new(2011),
  :finishdate => DateTime.new(2012)
  )
project.save
site = project.sites.new(
  :name => 'ec jungle gym',
  :zipcode => 94530
  )
site.save
site2 = project.sites.new(
  :name => 'ec playground', 
  :zipcode => 94530
  )
site2.save

sites = user.sites
puts sites

user.sites.each do |s|
  @site = pp s.name
  pp @site
end

we = WeatherEvent.new
we.save

project = Project.new
sites = @project.sites.build

report = ReportsPdf.new
report.testem_fields

email = "walter@stormsavvy.com"
AlertMailer.pester_admins(email).deliver
