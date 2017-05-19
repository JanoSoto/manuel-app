require 'rails_helper'

RSpec.describe "pets/new", type: :view do
  before(:each) do
    assign(:pet, Pet.new(
      :name => "MyString",
      :genre => "MyString",
      :race => nil,
      :observations => "MyText"
    ))
  end

  it "renders new pet form" do
    render

    assert_select "form[action=?][method=?]", pets_path, "post" do

      assert_select "input#pet_name[name=?]", "pet[name]"

      assert_select "input#pet_genre[name=?]", "pet[genre]"

      assert_select "input#pet_race_id[name=?]", "pet[race_id]"

      assert_select "textarea#pet_observations[name=?]", "pet[observations]"
    end
  end
end
