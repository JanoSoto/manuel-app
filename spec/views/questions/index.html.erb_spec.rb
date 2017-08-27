require 'rails_helper'

RSpec.describe "questions/index", type: :view do
  before(:each) do
    assign(:questions, [
      Question.create!(
        :statement => "Statement",
        :hint => "Hint",
        :score => 2,
        :survey => nil
      ),
      Question.create!(
        :statement => "Statement",
        :hint => "Hint",
        :score => 2,
        :survey => nil
      )
    ])
  end

  it "renders a list of questions" do
    render
    assert_select "tr>td", :text => "Statement".to_s, :count => 2
    assert_select "tr>td", :text => "Hint".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
