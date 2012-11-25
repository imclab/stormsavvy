class UserMailer < ActionMailer::Base

  # require './lib/weather/forecast_examiner.rb'

  default :from => "alerts@stormsavvy.com"
  # default :from => "doolin@inventiumsystems.com"

  def mailout(to = nil)
    @greeting = "Greetings"
    @users = User.all

    @users.each do |user|
      @user = user # `@user` is needed for the template

      if @user.has_site?
        mail(
          :from     => "alerts@stormsavvy.com",
          :to       => @user.email,
          :subject  => "Storm Savvy Project Status Notification"
          ).deliver
      end
    end
  end

  def noaa_forecast(to = nil)
    @users = User.all
    @users.each do |user|
      @user = user # `@user` is needed for the template
      if user.has_site?
        mail(
          :from     => "alerts@stormsavvy.com",
          :to       => user.email,
          :subject  => "NOAA Forecast Notification"
          ).deliver
      end
    end
  end
end
