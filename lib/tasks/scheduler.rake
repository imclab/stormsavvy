namespace :scheduler do

  desc "Mails out pester admins email" 
  task :dailynotice => :environment do
    admins = ['david.doolin+stormsavvy@gmail.com',
              'kharma@gmail.com',]
    admins.each do |address|
      UserMailer.pester_admins(address).deliver
    end
  end

  desc "Mails out POP alert notification"
  task :stormpopnotice => :environment do
    test_users = ['kharma@gmail.com']
    if user.sites.precipitation_state(forecast) == :imminent then
      test_users.each do |address|
        UserMailer.pop_alert(address).deliver
      end
    end
  end

  desc "Mails out NOAA forecast notification"
  task :noaaforecast => :environment do
  	test_users = ['kharma@gmail.com']
    test_users.each do |address|
  	  UserMailer.noaa_alert(address).deliver
  	end
  end

  desc "Mails out project and site names"
  task :mailout => :environment do
    UserMailer.mailout
  end

  # task :umtest => :environment do
  #   UserMailer.umtest
  # end
end