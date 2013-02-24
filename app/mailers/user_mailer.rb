class UserMailer < ActionMailer::Base

  default :from => "alerts@stormsavvy.com"

  def pester_admins(email)
    @numusers = User.count
    @numprojects = Project.count
    @numsites = Site.count
    @numinspections = InspectionEvent.count
    @numreports = Report.count

    @greeting = "Greetings"
    @forecast2 = NOAAForecast.new(94605)
    @forecast1 = @forecast2.get_forecast_array
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
    
    nf = NOAAForecast.new(94605)
    @forecast1 = nf.get_forecast_array

    mail(
      :from     => "alerts@stormsavvy.com",
      :to       => email,
      :subject  => "Storm Savvy Staging App Email"
      ).deliver
  end

  def mailout(to = nil)
    @greeting = "Greetings"
    @users = User.all

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
          @forecast = nf.get_forecast_array

          # @forecast = site.forecast

          # forecasts = []
          # forecasts << @forecast
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
