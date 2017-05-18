require 'rails_helper'

RSpec.describe "clients/index", type: :view do
  before(:each) do
    assign(:clients, [
      Client.create!(
        :clientRut => "Client Rut",
        :clientName => "Client Name",
        :clientLastName => "Client Last Name",
        :clientEmail => "Client Email",
        :clientCellPhone => 2,
        :clientAddress => "Client Address"
      ),
      Client.create!(
        :clientRut => "Client Rut",
        :clientName => "Client Name",
        :clientLastName => "Client Last Name",
        :clientEmail => "Client Email",
        :clientCellPhone => 2,
        :clientAddress => "Client Address"
      )
    ])
  end

  it "renders a list of clients" do
    render
    assert_select "tr>td", :text => "Client Rut".to_s, :count => 2
    assert_select "tr>td", :text => "Client Name".to_s, :count => 2
    assert_select "tr>td", :text => "Client Last Name".to_s, :count => 2
    assert_select "tr>td", :text => "Client Email".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "Client Address".to_s, :count => 2
  end
end
