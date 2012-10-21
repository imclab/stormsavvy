class AlertMailer < ActionMailer::Base
  default :from => "alerts@stormsavvy.com"

# Refactor alertmailer to action mailer
=begin
  def pop
    @greeting = "Storm Savvy Weather Alert"
    mail(
      :to => "#{user.login} <#{user.email}>",
      :subject => "Storm Savvy Weather Alert" 
      )
  end
=end

end
