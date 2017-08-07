require 'rails_helper'

RSpec.describe "answer_options/index", type: :view do
  before(:each) do
    assign(:answer_options, [
      AnswerOption.create!(
        :answer => "Answer",
        :score => 2,
        :question => nil
      ),
      AnswerOption.create!(
        :answer => "Answer",
        :score => 2,
        :question => nil
      )
    ])
  end

  it "renders a list of answer_options" do
    render
    assert_select "tr>td", :text => "Answer".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
