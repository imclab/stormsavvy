# Run inside console for testing nested attributes and mailers.

# Reload, delete and re-create user objects.
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

# Check for user sites
sites = user.sites
puts sites

# Use pp to output site names
user.sites.each do |s|
  @site = pp s.name
  pp @site
end

# Create weather event
we = WeatherEvent.new
we.save

# Create new project    
@project = Project.new
@sites = @project.sites.build

# Create first report
@report = report
@view = view
report = FirstReport.new(report, view, options)
report.save

report = ReportsPdf.new
report.testem_fields