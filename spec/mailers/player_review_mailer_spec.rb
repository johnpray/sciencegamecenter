require "spec_helper"

describe PlayerReviewMailer do
  describe "notify_for_approval" do
    let(:mail) { PlayerReviewMailer.notify_for_approval }

    it "renders the headers" do
      mail.subject.should eq("Notify for approval")
      mail.to.should eq(["to@example.org"])
      mail.from.should eq(["from@example.com"])
    end

    it "renders the body" do
      mail.body.encoded.should match("Hi")
    end
  end

end
