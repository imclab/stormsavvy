class UserMailer < ActionMailer::Base
  #default :from => "alerts@stormsavvy.com"
  default from: "doolin@inventiumsystems.com"
  #default :from => "david.doolin@gmail.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.alert_mailer.pop.subject
  #
  def pop
    @greeting = "Hi"
    mail to: "david.doolin@gmail.com", :subject => 'booyah'
  end

  def pop_alert(user)
    mail(:to => user.email, :subject => "Daily weather alerts")
  end

  def pester_admins(email)
    mail(:to => email, :subject => 'Storm Savvy is working great today!')
  end

  def noaa_forecast(email)
    mail(:to => email, :subject => 'Storm Savvy NOAA Forecast')
  end

end
