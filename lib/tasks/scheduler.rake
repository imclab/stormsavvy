
desc "This task is called by the Heroku scheduler add-on"

task :dailynotice => :environment do
  UserMailer.pop.deliver
end