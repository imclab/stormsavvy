
desc "This task is called by the Heroku scheduler add-on"

task :dailynotice => :environment do
    admins = ['david.doolin@gmail.com', 
              'david.doolin+storm@gmail.com']
    admins.each do |address|
      UserMailer.pester_admins(address).deliver
    end


end