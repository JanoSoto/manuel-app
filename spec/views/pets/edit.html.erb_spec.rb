require 'rails_helper'

RSpec.describe "pets/edit", type: :view do
  before(:each) do
    @pet = assign(:pet, Pet.create!(
      :name => "MyString",
      :genre => "MyString",
      :race => nil,
      :observations => "MyText"
    ))
  end

  it "renders the edit pet form" do
    render

    assert_select "form[action=?][method=?]", pet_path(@pet), "post" do

      assert_select "input#pet_name[name=?]", "pet[name]"

      assert_select "input#pet_genre[name=?]", "pet[genre]"

      assert_select "input#pet_race_id[name=?]", "pet[race_id]"

      assert_select "textarea#pet_observations[name=?]", "pet[observations]"
    end
  end
end
