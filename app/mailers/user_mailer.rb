class UserMailer < ActionMailer::Base

  require './lib/weather/forecast_examiner.rb'

  default :from => "alerts@stormsavvy.com"
  # default :from => "doolin@inventiumsystems.com"

  def pester_admins(email)
    @greeting = "Yo yo yo!"

    mail(
      :from => "alerts@stormsavvy.com",
      :to => "walter@stormsavvy.com",
      :subject => 'Storm Savvy is working great today!'
      ).deliver
  end

  def mailout(to = nil)
    mail(
      :from     => "alerts@stormsavvy.com",
      :subject  => "Storm Savvy Project Status Notification"
      ).deliver
    @users = User.all
    @users.each do |user|
      @user = user # `@user` is needed for the template
      if user.has_site?
        mail(
          :to => user.email
          ).deliver
      end
    end
  end

  def noaa_forecast(to = nil)
    mail(
      :from     => "alerts@stormsavvy.com",
      :to       => "walter@stormsavvy.com",
      :subject  => "NOAA Forecast Notification"
      ).deliver
    @users = User.all
    @users.each do |user|
      @user = user # `@user` is needed for the template
      if user.has_site?
        mail(
          :to => user.email
          ).deliver
      end
    end
  end
end
