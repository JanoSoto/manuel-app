require 'rails_helper'

RSpec.describe "payments/edit", type: :view do
  before(:each) do
    @payment = assign(:payment, Payment.create!(
      :description => "MyString",
      :amount => 1,
      :verified => false
    ))
  end

  it "renders the edit payment form" do
    render

    assert_select "form[action=?][method=?]", payment_path(@payment), "post" do

      assert_select "input#payment_description[name=?]", "payment[description]"

      assert_select "input#payment_amount[name=?]", "payment[amount]"

      assert_select "input#payment_verified[name=?]", "payment[verified]"
    end
  end
end
