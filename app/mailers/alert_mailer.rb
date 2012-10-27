class AlertMailer < ActionMailer::Base
  default :from => "alerts@stormsavvy.com"

  def pop_alert(user)
    @greeting = "Greetings"
    mail(
      :to       => "#{user.firstname} #{user.lastname} <#{user.email}>",
      :subject  => "Storm Savvy POP Alert"
      ).deliver
  end

  def noaa_alert(user)
    @greeting = "Greetings"
    mail(
      :to       => "#{user.firstname} #{user.lastname} <#{user.email}>",
      :subject  => "Storm Savvy Daily Weather Forecasts"
      ).deliver
  end

end