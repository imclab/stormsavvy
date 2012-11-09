class AlertMailer < ActionMailer::Base

  default :from => "alerts@stormsavvy.com"

  def pop_alert(user)

    @greeting = "Greetings,"
    @users = User.all
    
    @users.each do |user|
      @user = user # `@user` is needed for the template
      if @user.has_site?
        mail(
          :from     => "alerts@stormsavvy.com",
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
          :from     => "alerts@stormsavvy.com",
          :to       => "#{user.firstname} #{user.lastname} <#{user.email}>",
          :subject  => "Storm Savvy Daily Weather Forecasts"
          ).deliver
      end
    end
  end
end