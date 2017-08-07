require 'rails_helper'

RSpec.describe "questions/new", type: :view do
  before(:each) do
    assign(:question, Question.new(
      :statement => "MyString",
      :hint => "MyString",
      :score => 1,
      :survey => nil
    ))
  end

  it "renders new question form" do
    render

    assert_select "form[action=?][method=?]", questions_path, "post" do

      assert_select "input#question_statement[name=?]", "question[statement]"

      assert_select "input#question_hint[name=?]", "question[hint]"

      assert_select "input#question_score[name=?]", "question[score]"

      assert_select "input#question_survey_id[name=?]", "question[survey_id]"
    end
  end
end
