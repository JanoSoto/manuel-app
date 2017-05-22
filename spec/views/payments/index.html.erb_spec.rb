require 'rails_helper'

RSpec.describe "payments/index", type: :view do
  before(:each) do
    assign(:payments, [
      Payment.create!(
        :description => "Description",
        :amount => 2,
        :verified => false
      ),
      Payment.create!(
        :description => "Description",
        :amount => 2,
        :verified => false
      )
    ])
  end

  it "renders a list of payments" do
    render
    assert_select "tr>td", :text => "Description".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
