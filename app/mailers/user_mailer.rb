class UserMailer < ActionMailer::Base
  default :from => "doolin@inventiumsystems.com"
  #default :from => "alerts@stormsavvy.com"
  #default :from => "david.doolin@gmail.com"

  def pop
    @greeting = "Hello"
    mail to: "david.doolin@gmail.com", :subject => 'booyah'
  end

  def pop_alert(user)
    @greeting = "Hello"
    mail(:to => user.email, :subject => "Pop alerts")
  end

  def noaa_alert(user)
    @greeting = "Hello"
    mail(:to => user.email, :subject => "Daily weather forecasts")
  end

  def pester_admins(email)
    @greeting = "Yo yo yo!"
    mail(:to => email, :subject => 'Storm Savvy is working great today!')
  end

  def mailout(to = nil)
    @users = User.all
    @users.each do |user|
      @user = user # `@user` is needed for the template
      if user.has_site?
        mail(:to => user.email, :subject => "Project estimate").deliver
      end
    end
  end

end
