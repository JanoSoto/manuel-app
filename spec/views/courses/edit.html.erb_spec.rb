require 'rails_helper'

RSpec.describe "courses/edit", type: :view do
  before(:each) do
    @course = assign(:course, Course.create!(
      :name => "MyString",
      :semester => 1,
      :year => 1,
      :status => false,
      :user => nil
    ))
  end

  it "renders the edit course form" do
    render

    assert_select "form[action=?][method=?]", course_path(@course), "post" do

      assert_select "input#course_name[name=?]", "course[name]"

      assert_select "input#course_semester[name=?]", "course[semester]"

      assert_select "input#course_year[name=?]", "course[year]"

      assert_select "input#course_status[name=?]", "course[status]"

      assert_select "input#course_user_id[name=?]", "course[user_id]"
    end
  end
end
