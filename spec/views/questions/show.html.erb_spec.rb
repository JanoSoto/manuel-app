require 'rails_helper'

RSpec.describe "questions/show", type: :view do
  before(:each) do
    @question = assign(:question, Question.create!(
      :statement => "Statement",
      :hint => "Hint",
      :score => 2,
      :survey => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Statement/)
    expect(rendered).to match(/Hint/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(//)
  end
end
