class AlertMailer < ActionMailer::Base
  default :from => "doolin@inventiumsystems.com"

  def pop
    @greeting = "Hi"

    mail to: "to@example.org"
  end
end
