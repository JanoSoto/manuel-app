require 'rails_helper'

RSpec.describe "payments/new", type: :view do
  before(:each) do
    assign(:payment, Payment.new(
      :description => "MyString",
      :amount => 1,
      :verified => false
    ))
  end

  it "renders new payment form" do
    render

    assert_select "form[action=?][method=?]", payments_path, "post" do

      assert_select "input#payment_description[name=?]", "payment[description]"

      assert_select "input#payment_amount[name=?]", "payment[amount]"

      assert_select "input#payment_verified[name=?]", "payment[verified]"
    end
  end
end
