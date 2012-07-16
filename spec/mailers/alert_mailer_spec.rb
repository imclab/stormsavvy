require "spec_helper"

describe AlertMailer do
  describe "pop" do
    let(:mail) { AlertMailer.pop }

    it "renders the headers" do
      mail.subject.should eq("Pop")
      mail.to.should eq(["to@example.org"])
      mail.from.should eq(["doolin@inventiumsystems.com"])
    end

    it "renders the body" do
      mail.body.encoded.should match("Hi")
    end

  end
end
