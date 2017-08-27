require 'rails_helper'

RSpec.describe "answer_options/show", type: :view do
  before(:each) do
    @answer_option = assign(:answer_option, AnswerOption.create!(
      :answer => "Answer",
      :score => 2,
      :question => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Answer/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(//)
  end
end
