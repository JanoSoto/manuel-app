require 'rails_helper'

RSpec.describe "AnswerOptions", type: :request do
  describe "GET /answer_options" do
    it "works! (now write some real specs)" do
      get answer_options_path
      expect(response).to have_http_status(200)
    end
  end
end
