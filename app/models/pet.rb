class Pet < ActiveRecord::Base
  belongs_to :race
  belongs_to :client
end
