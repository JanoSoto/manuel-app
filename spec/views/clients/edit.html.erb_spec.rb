require 'rails_helper'

RSpec.describe "clients/edit", type: :view do
  before(:each) do
    @client = assign(:client, Client.create!(
      :clientRut => "MyString",
      :clientName => "MyString",
      :clientLastName => "MyString",
      :clientEmail => "MyString",
      :clientCellPhone => 1,
      :clientAddress => "MyString"
    ))
  end

  it "renders the edit client form" do
    render

    assert_select "form[action=?][method=?]", client_path(@client), "post" do

      assert_select "input#client_clientRut[name=?]", "client[clientRut]"

      assert_select "input#client_clientName[name=?]", "client[clientName]"

      assert_select "input#client_clientLastName[name=?]", "client[clientLastName]"

      assert_select "input#client_clientEmail[name=?]", "client[clientEmail]"

      assert_select "input#client_clientCellPhone[name=?]", "client[clientCellPhone]"

      assert_select "input#client_clientAddress[name=?]", "client[clientAddress]"
    end
  end
end
