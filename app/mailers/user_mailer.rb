class UserMailer < ActionMailer::Base

  default :from => "alerts@stormsavvy.com"

  def pester_admins(email)
    @numusers = User.count
    @numprojects = Project.count
    @numsites = Site.count
    @numinspections = InspectionEvent.count
    @numreports = Report.count

    @greeting = "Greetings"
    zipcode = 94530
    nf = NOAAForecast.new(zipcode)
    @forecast1 = nf.get_forecast_array(zipcode)
    @salutation = "The Storm Savvy Team"

    mail(
      :from     => "alerts@stormsavvy.com",
      :to       => email,
      :subject  => "Storm Savvy Daily Admin Email"
      ).deliver
  end

  def staging_mailer(email)
    @numusers = User.count
    @numprojects = Project.count
    @numsites = Site.count
    @numinspections = InspectionEvent.count
    @numreports = Report.count

    @greeting = "Greetings"
    @salutation = "The Storm Savvy Team"

    zipcode = 94605
    nf = NOAAForecast.new(zipcode)
    @forecast1 = nf.get_forecast_array(zipcode)

    mail(
      :from     => "alerts@stormsavvy.com",
      :to       => email,
      :subject  => "Storm Savvy Staging App Email"
      ).deliver
  end

  def mailout(to = nil)
    @greeting = "Greetings"
    @users = User.all
    @salutation = "The Storm Savvy Team"

    @users.each do |user|
      @user = user # needed for the template below
      @projects = @user.projects

      @projects.each do |project|
        @project = project
        @sites = @project.sites

        @sites.each do |site|
          @site = site
          zipcode = @site.zipcode
          nf = NOAAForecast.new(zipcode)
          @forecast = nf.forecast_by_zipcode(zipcode)

          @reports = Report.where(:status => "needs_attention")
        end
      end

      if @user.has_site?
        mail(
          :from     => "alerts@stormsavvy.com",
          :to       => @user.email,
          :subject  => "Storm Savvy Weekly Project Status Update"
          ).deliver
      end
    end
  end

  def thankyou(email)
    @greeting = "Greetings"
    @salutation = "The Storm Savvy Team"

    mail(
      :from     => "alerts@stormsavvy.com",
      :to       => email,
      :subject  => "Storm Savvy Sign-up Confirmation"
      ).deliver
  end
end
