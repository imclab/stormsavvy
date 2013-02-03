namespace :scheduler do

  desc "Delivers northbay_forecast mailer"
  task :northbay_forecast => :environment do
    test_users = [
      'walter@stormsavvy.com',
      'wing.wingyu@gmail.com'
      ]
    test_users.each do |address|
      AlertMailer.northbay_forecast(address).deliver
    end
    # end
  end

  desc "Delivers eastbay_forecast mailer"
  task :eastbay_forecast => :environment do
    test_users = [
      'walter@stormsavvy.com',
      'wing.wingyu@gmail.com'
      ]
    test_users.each do |address|
      AlertMailer.eastbay_forecast(address).deliver
    end
  end

  desc "Delivers popalert mailer"
  task :popalert => :environment do
    test_users = [
      'walter@stormsavvy.com',
      'wing.wingyu@gmail.com'
      ]
    test_users.each do |address|
      AlertMailer.pop_alert(address).deliver
    end
  end

  desc "Delivers noaa_alert mailer"
  task :noaaalert => :environment do
  	test_users = [
      'walter@stormsavvy.com'
      ]
    # if user.sites.precipitation_state(forecast) == :imminent then
    test_users.each do |address|
  	  AlertMailer.noaa_alert(address).deliver
  	end
  end

  desc "Delivers pester_admins mailer"
  task :dailynotice => :environment do
    admins = [
      'walter@stormsavvy.com',
      'wing.wingyu@gmail.com',
      'david.doolin+stormsavvy@gmail.com',
      ]
    admins.each do |address|
      UserMailer.pester_admins(address).deliver
    end
  end

  desc "Delivers mailout mailer"
  task :mailout => :environment do
  	test_users = [
      'walter@stormsavvy.com'
      ]
    test_users.each do |address|
      UserMailer.mailout
    end
  end

  desc "Delivers thank you mailer"
  task :thankyou => :environment do
    test_users = [
      'walter@stormsavvy.com'
      ]
    test_users.each do |address|
      UserMailer.thankyou(address).deliver
    end
  end
end
