# Run inside console for testing nested attributes and mailers.

# Reload, delete and re-create user objects.
user.delete
project.delete
site.delete
site2.delete
reload!
user = User.new(
	:email => 'foo1@bar.com',
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

# Check for user site forecasts
user.sites
user.print_sites

# Check for user sites
sites = user.sites
puts sites

# Use pp to output site names
user.sites.each do |s|
  @site = pp s.name
  pp @site
end
