
desc "This task is called by the Heroku scheduler add-on"

task :dailynotice => :environment do
    admins = ['kharma+storm@gmail.com', 
              'david.doolin+storm@gmail.com']
    admins.each do |address|
      UserMailer.pester_admins(address).deliver
    end

task :weatherforecast => :environment do
	test_users = ['kharma+storm@gmail.com', 
              'david.doolin+storm@gmail.com']
      test_users.each do |address|
	  UserMailer.noaa_forecast(address).deliver
	end

# task :stormpopnotice => :environment do
# 	test_users = ['kharma+storm@gmail.com', 
#               'david.doolin+storm@gmail.com']
#     if user.sites.precipitation_state(forecast) == :imminent then
#       test_users.each do |address|
# 	  UserMailer.pop_alert(address).deliver
# 	end
end