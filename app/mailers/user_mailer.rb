class UserMailer < ActionMailer::Base
  #default :from => "alerts@stormsavvy.com"
  default :from => "doolin@inventiumsystems.com"
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
    @greeting = "Yo yo yo!"
    mail(:to => email, :subject => 'Storm Savvy is working great today!')
  end

  # NOAA-specific data
  def noaa_forecast(email)
    emails = []
    @users = User.all
    @users.each do |user|
      user.sites.each do |s|
        @greeting = "Hi #{user.email}"
        @forecast = s.forecast
        emails << mail(:to => user.email, 
                       :subject => "Storm Savvy NOAA Forecast for #{s.name}").deliver # do |format|
                  #   format.text
                  #   format.html
                  # end
      end
#      if user.has_site?
#        @site = user.sites[0]
#        mail(:to => user.email, :subject => "Storm Savvy NOAA Forecast for #{@site.name}").deliver
#      end
    end
    #mail(:to => email, :subject => 'Storm Savvy NOAA Forecast')
  end

  def mailout(to = nil)
    @users = User.all
    User.all.each do |user|
      @user = user 
      if user.has_site?
        mail(:to => user.email, :subject => "Project estimate").deliver
      end
    end
  end

end
