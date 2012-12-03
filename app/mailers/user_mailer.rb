class UserMailer < ActionMailer::Base

  # require './lib/weather/forecast_examiner.rb'
  include UserMailerHelper

  default :from => "alerts@stormsavvy.com"
  # default :from => "doolin@inventiumsystems.com"

  def pester_admins(email)
    @numusers = User.count
    @numprojects = Project.count
    @numsites = Site.count

    @weather = NOAAForecast.new(94605)
    @forecast_array = @weather.seven_day_weather[0]
    @forecast_string = @forecast_array.join("  ")

    @time_array = (1.month.ago.to_date..Date.today).map{ |date| date.strftime("%b %d") }
    @time_string = @time_array.join("  ")

    @greeting = "Greetings"
    mail(
      :from     => "alerts@stormsavvy.com",
      :to       => email,
      :subject  => "Storm Savvy POP Alert"
      ).deliver
  end

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

end
