namespace :scheduler do

  desc "Delivers pop_alert mailer"
  task :stormpopnotice => :environment do
    test_users = [
      'walter@stormsavvy.com',
      'kharma@gmail.com'
      ]
    # if user.sites.precipitation_state(forecast) == :imminent then
    test_users.each do |address|
      AlertMailer.pop_alert(address).deliver
    end
    # end
  end

  desc "Delivers noaa_alert mailer"
  task :noaaalert => :environment do
  	test_users = [
      'walter@stormsavvy.com',
      'kharma@gmail.com'
      ]
    test_users.each do |address|
  	  AlertMailer.noaa_alert(address).deliver
  	end
  end

  desc "Delivers pester_admins mailer"
  task :dailynotice => :environment do
    admins = [
      'david.doolin+stormsavvy@gmail.com',
      'adam@adambarber.tv',
      'walter@stormsavvy.com',
      'kharma@gmail.com'
      ]
    admins.each do |address|
      UserMailer.pester_admins(address).deliver
    end
  end

  desc "Delivers project and site names"
  task :mailout => :environment do
  	test_users = [
      'walter@stormsavvy.com',
      'kharma@gmail.com'
      ]
    test_users.each do |address|
      UserMailer.mailout
    end
  end
end
