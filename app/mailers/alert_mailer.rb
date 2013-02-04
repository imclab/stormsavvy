class AlertMailer < ActionMailer::Base

  default :from => "sendgrid@stormsavvy.com"

  def northbay_forecast(email)
    @greeting = "Greetings"
    @salutation = "The Storm Savvy Team"
    @support = "Questions? Email us at info@stormsavvy.com!"

    @location1 = "San Rafael, CA 94901"
    @nf1 = NOAAForecast.new(94901)
    @nf2 = @nf1.forecast_by_zipcode(94901)

    @location2 = "Novato, CA 94949"
    @nf3 = NOAAForecast.new(94949)
    @nf4 = @nf3.forecast_by_zipcode(94949)

    @location3 = "Petaluma, CA 94954"
    @nf5 = NOAAForecast.new(94954)
    @nf6 = @nf5.forecast_by_zipcode(94954)

    @location4 = "Rohnert Park, CA 94928"
    @nf7 = NOAAForecast.new(94928)
    @nf8 = @nf7.forecast_by_zipcode(94928)

    mail(
      :from     => "sendgrid@stormsavvy.com",
      :to       => email,
      :subject  => "Storm Savvy Daily Forecast: North Bay"
      ).deliver
  end

  def eastbay_forecast(email)
    @greeting = "Greetings"
    @salutation = "The Storm Savvy Team"
    @support = "Questions? Email us at info@stormsavvy.com!"

    @location1 = "Oakland, CA 94621"
    @nf1 = NOAAForecast.new(94621)
    @nf2 = @nf1.forecast_by_zipcode(94621)

    @location2 = "Berkeley, CA 94709"
    @nf3 = NOAAForecast.new(94709)
    @nf4 = @nf3.forecast_by_zipcode(94709)

    @location3 = "Walnut Creek, CA 94596"
    @nf5 = NOAAForecast.new(94596)
    @nf6 = @nf5.forecast_by_zipcode(94596)

    @location4 = "Pleasanton, CA 94566"
    @nf7 = NOAAForecast.new(94566)
    @nf8 = @nf7.forecast_by_zipcode(94566)

    mail(
      :from     => "sendgrid@stormsavvy.com",
      :to       => email,
      :subject  => "Storm Savvy Daily Forecast: East Bay"
      ).deliver
  end

  def southbay_forecast(email)
    @greeting = "Greetings"
    @salutation = "The Storm Savvy Team"
    @support = "Questions? Email us at info@stormsavvy.com!"

    @location1 = "Fremont, CA 94538"
    @nf1 = NOAAForecast.new(94538)
    @nf2 = @nf1.forecast_by_zipcode(94538)

    @location2 = "Sunnyvale, CA 94087"
    @nf3 = NOAAForecast.new(94087)
    @nf4 = @nf3.forecast_by_zipcode(94087)

    @location3 = "San Jose, CA 95113"
    @nf5 = NOAAForecast.new(95113)
    @nf6 = @nf5.forecast_by_zipcode(95113)

    @location4 = "Palo Alto, CA 94305"
    @nf7 = NOAAForecast.new(94305)
    @nf8 = @nf7.forecast_by_zipcode(94305)

    mail(
      :from     => "sendgrid@stormsavvy.com",
      :to       => email,
      :subject  => "Storm Savvy Daily Forecast: South Bay"
      ).deliver
  end

  def noaa_forecast(to = nil)
    @users = User.all
    @users.each do |user|
      @user = user # `@user` is needed for the template
      if user.has_site?
        mail(
          :from     => "sendgrid@stormsavvy.com",
          :to       => user.email,
          :subject  => "NOAA Forecast Notification"
          ).deliver
      end
    end
  end

  def noaa_alert(user)
    @greeting = "Greetings"
    @salutation = "The Storm Savvy Team"
    @support = "Questions? Email us at info@stormsavvy.com!"

    @users = User.all
    @users.each do |user|
      @user = user # `@user` is needed for the template
      if @user.has_site?
        mail(
          :from     => "sendgrid@stormsavvy.com",
          :to       => "#{user.firstname} #{user.lastname} <#{user.email}>",
          :subject  => "Storm Savvy Daily Weather Forecasts"
          ).deliver
      end
    end
  end

  def pop_alert(user)
    @greeting = "Greetings,"
    @salutation = "The Storm Savvy Team"
    @support = "Questions? Email us at info@stormsavvy.com!"

    @users = User.all
    # if @forecast == :imminent then
    @users.each do |user|
      @user = user # `@user` is needed for the template
      if @user.has_site?
        mail(
          :from     => "sendgrid@stormsavvy.com",
          :to       => "#{user.firstname} #{user.lastname} <#{user.email}>",
          :subject  => "Storm Savvy POP Alert"
          ).deliver
      end
    end
  end
end
