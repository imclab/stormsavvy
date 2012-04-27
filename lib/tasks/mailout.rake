namespace :mailout do

  desc "Mails out project and site names"
  task :mailout => :environment do
    UserMailer.mailout
  end
end
