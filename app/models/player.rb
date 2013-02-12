class Player < ActiveRecord::Base
  attr_accessible :name
  attr_accessible :team_id
  belongs_to :team
  has_and_belongs_to_many :lines, :join_table => "line_players"
end
