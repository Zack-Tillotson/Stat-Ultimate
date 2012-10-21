class Player < ActiveRecord::Base
  attr_accessible :name
  attr_accessible :team_id
  belongs_to :team
end
