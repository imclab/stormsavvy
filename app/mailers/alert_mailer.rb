class AlertMailer < ActionMailer::Base

  default :from => "sendgrid@stormsavvy.com"


  def noaa_forecast(to = nil)
    @users = User.all
    @users.each do |user|
      @user = user # `@user` is needed for the template
      if user.has_site?
        mail(
          :from     => "sendgrid@stormsavvy.com",
          :to       => user.email,
          :subject  => "NOAA Forecast Notification"
          ).deliver
      end
    end
  end

  def pop_alert(user)

    @greeting = "Greetings,"
    @users = User.all

    @users.each do |user|
      @user = user # `@user` is needed for the template
      if @user.has_site?
        mail(
          :from     => "sendgrid@stormsavvy.com",
          :to       => "#{user.firstname} #{user.lastname} <#{user.email}>",
          :subject  => "Storm Savvy POP Alert"
          ).deliver
      end
    end
  end

  def noaa_alert(user)

    @greeting = "Greetings,"
    @users = User.all
    @users.each do |user|
      @user = user # `@user` is needed for the template
      if @user.has_site?
        mail(
          :from     => "sendgrid@stormsavvy.com",
          :to       => "#{user.firstname} #{user.lastname} <#{user.email}>",
          :subject  => "Storm Savvy Daily Weather Forecasts"
          ).deliver
      end
    end
  end
end
