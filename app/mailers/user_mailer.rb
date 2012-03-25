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
    @greeting = "Yo yo yo!"
    mail(:to => email, :subject => 'Storm Savvy is working great today!')
  end

  # NOAA-specific data
  def noaa_forecast(user)
    mail(:to => user.email, :subject => 'Storm Savvy NOAA Forecast')
  end

  def weather_forecast(email)
    @greeting = "It's Storm Savvy weather time!"
    mail(:to => email, :subject => 'Storm Savvy Weather Forecast')
  end

  def umtest
    admins = ['david.doolin+stormsavvy@gmail.com']
    user = User.where(:email => 'david.doolin@gmail.com')
    admins.each do |address|
      mail(:to => address, :subject => 'From the :umtest method of UserMailer').deliver
    end
  end

  def mailout
    User.all.each do |user|
      ending = "\r\n"
      body = "Your projects" + ending
      body += "=" * 15 + ending
      user.projects.each do |project|
        body += "Project  #{project.name}" + ending

        project.sites.each do |site|
          body += "  Site #{site.name} | Percent of Precipatation #{site.chance_of_rain}%" + ending
        end
      end
      mail(:to => user.email, :subject => "Your projects", :body => body).deliver
    end
  end

end
