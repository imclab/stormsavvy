class UserMailer < ActionMailer::Base

  default :from => "alerts@stormsavvy.com"

  def set_vars
    @numusers = User.count
    @numprojects = Project.count
    @numsites = Site.count
    @numinspections = InspectionEvent.count
    @numreports = Report.count
    @greeting = "Greetings"
    @salutation = "The Storm Savvy Team"
    @support = "Questions? Email us at walter@stormsavvy.com!"
  end

  def pester_admins(email)
    set_vars
    zipcode = 94530
    nf = NOAAForecast.new(zipcode)
    @forecast1 = nf.get_forecast_array(zipcode)

    mail(
      :to       => email,
      :subject  => "Storm Savvy Daily Admin Email"
      ).deliver
  end

  def staging_mailer(email)
    set_vars
    zipcode = 94605
    nf = NOAAForecast.new(zipcode)
    @forecast1 = nf.get_forecast_array(zipcode)

    mail(
      :to       => email,
      :subject  => "Storm Savvy Staging App Email"
      ).deliver
  end

  def mailout(to = nil)
    @users = User.all
    @users.each do |user|
      @user = user # needed for the template below
      @sites = @user.sites
      @sites.each do |site|
        @site = site
        @reports = site.reports
        @pending_ie = site.inspection_events

          # zipcode = @site.zipcode
          # nf = NOAAForecast.new(zipcode)
          # @forecast = nf.forecast_by_zipcode(zipcode)
          # @reports = Report.where(:status => "needs_attention")
        # end
      end

      if @user.has_site?
        mail(
          :to       => @user.email,
          :subject  => "Storm Savvy Weekly Project Status"
          ).deliver
      end
    end
  end

  def thankyou(email)
    mail(
      :to       => email,
      :subject  => "Storm Savvy Sign-up Confirmation"
      ).deliver
  end
end
