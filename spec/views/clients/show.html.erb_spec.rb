require 'rails_helper'

RSpec.describe "clients/show", type: :view do
  before(:each) do
    @client = assign(:client, Client.create!(
      :clientRut => "Client Rut",
      :clientName => "Client Name",
      :clientLastName => "Client Last Name",
      :clientEmail => "Client Email",
      :clientCellPhone => 2,
      :clientAddress => "Client Address"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Client Rut/)
    expect(rendered).to match(/Client Name/)
    expect(rendered).to match(/Client Last Name/)
    expect(rendered).to match(/Client Email/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/Client Address/)
  end
end
