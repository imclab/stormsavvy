class UserMailer < ActionMailer::Base
  default :from => "alerts@stormsavvy.com"
  # default :from => "doolin@inventiumsystems.com"

  def pester_admins(email)
    @greeting = "Yo yo yo!"
    mail(
      :to => "walter@stormsavvy.com",
      :subject => 'Storm Savvy is working great today!'
      ).deliver
  end

  def mailout(to = nil)
    @users = User.all
    @users.each do |user|
      @user = user # `@user` is needed for the template
      if user.has_site?
        mail(
          :to => user.email,
          :subject => "Storm Savvy Project Status Notification"
          ).deliver
      end
    end
  end

end
