namespace :scheduler do

  desc "Delivers northbay_forecast mailer"
  task :northbay_forecast => :environment do
    test_users = [
      'walter@stormsavvy.com',
      'walter_yu@dot.ca.gov',
      'kharma+stormsavvy@gmail.com',
      'wing.wingyu@gmail.com',
      'david.doolin+stormsavvy@gmail.com'
      # 'JonathanM@ghilottibros.com',
      # 'KjellD@ghilottibros.com'
      ]
    test_users.each do |address|
      AlertMailer.northbay_forecast(address)
    end
  end

  desc "Delivers eastbay_forecast mailer"
  task :eastbay_forecast => :environment do
    test_users = [
      'walter@stormsavvy.com',
      'wing.wingyu@gmail.com'
      ]
    test_users.each do |address|
      AlertMailer.eastbay_forecast(address)
    end
  end

  desc "Delivers southbay_forecast mailer"
  task :southbay_forecast => :environment do
    test_users = [
      'walter@stormsavvy.com',
      'wing.wingyu@gmail.com'
      ]
    test_users.each do |address|
      AlertMailer.southbay_forecast(address)
    end
  end

  desc "Delivers popalert mailer"
  task :popalert => :environment do
    test_users = [
      'walter@stormsavvy.com',
      'wing.wingyu@gmail.com'
      ]
    test_users.each do |address|
      AlertMailer.pop_alert(address)
    end
  end

  desc "Delivers noaa_alert mailer"
  task :noaaalert => :environment do
  	test_users = [
      'walter@stormsavvy.com'
      ]
    # if user.sites.precipitation_state(forecast) == :imminent then
    test_users.each do |address|
  	  AlertMailer.noaa_alert(address)
  	end
  end

  desc "Delivers pester_admins mailer"
  task :dailynotice => :environment do
    admins = [
      'walter@stormsavvy.com',
      'wing.wingyu@gmail.com',
      'david.doolin+stormsavvy@gmail.com'
      ]
    admins.each do |address|
      UserMailer.pester_admins(address)
    end
  end

  desc "Delivers staging_mailer mailer"
  task :staging_mailer => :environment do
    if Time.now.sunday? # weekly scheduler: http://goo.gl/Bj6zL
      admins = [
        'walter@stormsavvy.com'
        ]
      admins.each do |address|
        UserMailer.staging_mailer(address)
      end
    end
  end

  desc "Delivers mailout mailer"
  task :mailout => :environment do
  	users = [
      'walter@stormsavvy.com'
      ]
    users.each do |address|
      UserMailer.mailout
    end
  end

  desc "Delivers thank you mailer"
  task :thankyou => :environment do
    test_users = [
      'walter@stormsavvy.com'
      ]
    test_users.each do |address|
      UserMailer.thankyou(address)
    end
  end

  desc "Checks inspection event workflow"
  task :iew => :environment do
    iew = InspectionEventWorkflow.new
    iew.inspection_needed?
  end
end
