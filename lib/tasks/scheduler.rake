namespace :scheduler do

  desc "runs rake spec"
  RSpec::Core::RakeTask.new(:spec)
  task run_spec: :spec

  desc "delivers northbay_forecast mailer"
  task northbay_forecast: :environment do
    test_users = [
      'walter@stormsavvy.com',
      'kharma+stormsavvy@gmail.com',
      'wing.wingyu@gmail.com',
      'david.doolin+stormsavvy@gmail.com'
      ]
    test_users.each do |address|
      AlertMailer.northbay_forecast(address)
    end
  end

  desc "delivers pop_alert mailer"
  task pop_alert: :environment do
    # test_users = [
    #   'walter@stormsavvy.com',
    #   'kharma+stormsavvy@gmail.com'
    # ]
    # if user.sites.precipitation_state(forecast) == :imminent then
    # test_users.each do |address|
    #   AlertMailer.pop_alert(address)
    #   AlertMailer.delay.pop_alert(address)
    # end

    # dummy values only, run mailer via check_pop_alert
    user = User.find_by(email: 'walter@stormsavvy.com')
    site = user.sites.first
    AlertMailer.pop_alert(user, site)
  end

  desc "checks for pop_alert mailer"
  task check_pop_alert: :environment do
    user = User.find_by(email: 'walter@stormsavvy.com')
    AlertMailer.check_pop_alert(user)
  end

  desc "delivers daily_mailer mailer"
  task daily_mailer: :environment do
    # Do not send to all users
    # users = User.all
    admins = [ (User.find_by email: 'walter@stormsavvy.com') ]
    admins.each do |user|
  	  AlertMailer.daily_mailer(user)
  	end
  end

  desc "delivers pester_admins mailer"
  task pester_admins: :environment do
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

  desc "delivers staging_mailer mailer"
  task staging_mailer: :environment do
    if Time.now.sunday?
      admins = [
        'walter@stormsavvy.com',
        'kharma+stormsavvy@gmail.com'
      ]
      admins.each do |address|
        UserMailer.staging_mailer(address)
        # UserMailer.delay.staging_mailer(address)
      end
    end
  end

  desc "delivers mailout mailer"
  task mailout: :environment do
  	users = [
      'walter@stormsavvy.com',
      'kharma+stormsavvy@gmail.com'
    ]
    users.each do |address|
      UserMailer.mailout(address)
      # UserMailer.delay.mailout
    end
  end

  desc "delivers thank you mailer"
  task thankyou: :environment do
    test_users = [
      # 'walter@stormsavvy.com',
      # 'kharma+stormsavvy@gmail.com'
    ]
    test_users.each do |address|
      UserMailer.thankyou(address)
      # UserMailer.delay.thankyou(address)
    end
  end

  desc "checks inspection event workflow"
  task iew: :environment do
    iew = InspectionEventWorkflow.new
    iew.inspection_needed?
  end

  desc "caches noaa_table"
  task noaa_table: :environment do
    # Do not send to all users
    # users = User.all
    users = [ (User.find_by email: 'walter@stormsavvy.com') ]
    users.each do |user|
      user.sites.each do |site|
        Rails.cache.fetch('forecast', expires_in: 60.minutes) do
          site.noaa_table
        end
        Rails.cache.fetch('forecast') { site.noaa_table }
      end
    end
  end

  desc "caches wg_forecast"
  task wg_forecast: :environment do
    # Do not send to all users
    # users = User.all
    users = [ (User.find_by email: 'walter@stormsavvy.com') ]
    users.each do |user|
      user = User.new
      user.sites.each do |site|
        Rails.cache.fetch('forecast', expires_in: 60.minutes) do
          site.wg_table
        end
        Rails.cache.fetch('forecast') { site.wg_table }
      end
  	end
  end
end
