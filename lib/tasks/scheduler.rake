namespace :scheduler do

  desc "Delivers northbay_forecast mailer"
  task :northbay_forecast => :environment do
    test_users = [
      'walter@stormsavvy.com',
      'walter_yu@dot.ca.gov',
      'kharma+stormsavvy@gmail.com',
      'wing.wingyu@gmail.com',
      'david.doolin+stormsavvy@gmail.com'
      ]
    test_users.each do |address|
      AlertMailer.northbay_forecast(address)
    end
  end

  desc "Delivers popalert mailer"
  task :pop_alert => :environment do
    test_users = [
      'walter@stormsavvy.com',
      'kharma+stormsavvy@gmail.com',
      'wing.wingyu@gmail.com'
      ]
    # if user.sites.precipitation_state(forecast) == :imminent then
    test_users.each do |address|
      AlertMailer.delay.pop_alert(address)
    end
  end

  desc "Delivers noaa_forecast mailer"
  task :noaa_forecast => :environment do
    # Do not send to all users
    # users = User.all

    admins = [ (User.find_by email: 'walter@stormsavvy.com') ]
    admins.each do |user|
  	  AlertMailer.noaa_forecast(user)
  	end
  end

  desc "Delivers pester_admins mailer"
  task :pester_admins => :environment do
    admins = [
      'walter@stormsavvy.com',
      'kharma+stormsavvy@gmail.com',
      'wing.wingyu@gmail.com',
      'david.doolin+stormsavvy@gmail.com'
      ]
    admins.each do |address|
      UserMailer.pester_admins(address)
      # UserMailer.delay.pester_admins(address)
    end
  end

  desc "Delivers staging_mailer mailer"
  task :staging_mailer => :environment do
    if Time.now.sunday? # weekly scheduler: http://goo.gl/Bj6zL
      admins = [
        'walter@stormsavvy.com',
        'kharma+stormsavvy@gmail.com'
        ]
      admins.each do |address|
        UserMailer.delay.staging_mailer(address)
      end
    end
  end

  desc "Delivers mailout mailer"
  task :mailout => :environment do
  	users = [
      'walter@stormsavvy.com',
      'kharma+stormsavvy@gmail.com'
      ]
    users.each do |address|
      UserMailer.delay.mailout
    end
  end

  desc "Delivers thank you mailer"
  task :thankyou => :environment do
    test_users = [
      'walter@stormsavvy.com',
      'kharma+stormsavvy@gmail.com'
      ]
    test_users.each do |address|
      UserMailer.delay.thankyou(address)
    end
  end

  desc "Checks inspection event workflow"
  task :iew => :environment do
    iew = InspectionEventWorkflow.new
    iew.inspection_needed?
  end
end
