require "rails_helper"

RSpec.describe AnswerOptionsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/answer_options").to route_to("answer_options#index")
    end

    it "routes to #new" do
      expect(:get => "/answer_options/new").to route_to("answer_options#new")
    end

    it "routes to #show" do
      expect(:get => "/answer_options/1").to route_to("answer_options#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/answer_options/1/edit").to route_to("answer_options#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/answer_options").to route_to("answer_options#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/answer_options/1").to route_to("answer_options#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/answer_options/1").to route_to("answer_options#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/answer_options/1").to route_to("answer_options#destroy", :id => "1")
    end

  end
end
