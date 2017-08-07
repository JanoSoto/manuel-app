require 'rails_helper'

RSpec.describe "answer_options/edit", type: :view do
  before(:each) do
    @answer_option = assign(:answer_option, AnswerOption.create!(
      :answer => "MyString",
      :score => 1,
      :question => nil
    ))
  end

  it "renders the edit answer_option form" do
    render

    assert_select "form[action=?][method=?]", answer_option_path(@answer_option), "post" do

      assert_select "input#answer_option_answer[name=?]", "answer_option[answer]"

      assert_select "input#answer_option_score[name=?]", "answer_option[score]"

      assert_select "input#answer_option_question_id[name=?]", "answer_option[question_id]"
    end
  end
end
