require "spec_helper"

describe AlertMailer do
  describe "pop" do
    let(:mail) { AlertMailer.pop }

    it "renders the headers" do
      mail.subject.should eq("Pop")
      mail.to.should eq(["to@example.org"])
      mail.from.should eq(["from@example.com"])
    end

    it "renders the body" do
      mail.body.encoded.should match("Hi")
    end

    xit "should be set to be delivered to the email passed in" do
      @email.should deliver_to("youremail@addresshere.com")
    end

    xit "should contain the user's message in the mail body" do
      @email.should have_body_text(/Hi/)
    end

    xit "should have the correct subject" do
      @email.should have_subject(/Pop/)
    end
  end
end