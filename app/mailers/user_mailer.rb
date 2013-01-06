class UserMailer < ActionMailer::Base

  default :from => "alerts@stormsavvy.com"

  def pester_admins(email)
    @numusers = User.count
    @numprojects = Project.count
    @numsites = Site.count

    @greeting = "Greetings"
    @forecast2 = NOAAForecast.new(94605)
    @forecast1 = @forecast2.get_forecast_array

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
