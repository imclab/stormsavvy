require "spec_helper"

# http://robaldred.co.uk/2009/12/testing-actionmailer-models-with-rspec/
# http://stackoverflow.com/questions/5843284/clearing-out-activemailerbase-deliveries-after-rspec-test
describe UserMailer do

  it "creates a valid UserMailer" do
  end

  before { ActionMailer::Base.deliveries = [] }

  it "should send pop alert emails" do
    user = Factory(:user)
    UserMailer.pop_alert(user).deliver
    ActionMailer::Base.deliveries.should_not be_empty
  end


=begin
  describe "alert" do

    before(:each) do
      @order = mock_model(Order)
      @order.customer = mock_model(Customer)
    end

    it "should render successfully" do
      lambda { OrderMailer.create_receipt(@order) }.should_not raise_error
    end

    describe "rendered without error" do

      before(:each) do
        @mailer = OrderMailer.create_receipt(@order)
      end

      it "should have an order number" do
        @mailer.body.should have_tag('.order_number', :text => @order.id)
      end

      it "should have order details" do
        @mailer.body.should have_tag(".order_details")
      end

      it "should have a billing address" do
        @mailer.body.should have_tag(".billing.address")
      end

      it "should have a delivery address" do
        @mailer.body.should have_tag(".delivery.address")
      end

      it "should have customer contact details" do
        @mailer.body.should have_tag("#contact_details") do
          with_tag('.landline', :text => @order.customer.landline)
          with_tag('.mobile', :text => @order.customer.mobile)
          with_tag('.email', :text => @order.customer.email)
        end
      end

      it "should have a list of items" do
        @mailer.body.should have_tag(".line_items")
      end

      it "should have totals" do
        @mailer.body.should have_tag(".totals") do
          with_tag('.sub_total', :text => format_price(@order.sub_total))
          with_tag('.vat', :text => format_price(@order.vat))
          with_tag('.postage', :text => format_price(@order.postage))
          with_tag('.total', :text => format_price(@order.total))
        end
      end

      it "should deliver successfully" do
        lambda { OrderMailer.deliver(@mailer) }.should_not raise_error
      end

      describe "and delivered" do

        it "should be added to the delivery queue" do
          lambda { OrderMailer.deliver(@mailer) }.should change(ActionMailer::Base.deliveries,:size).by(1)
        end

      end
    end
  end
=end

end