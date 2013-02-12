class Line < ActiveRecord::Base
  attr_accessible :scored, :active, :game_id, :players, :player_ids
  belongs_to :game
  has_many :line_players
  has_many :players, :through => :line_players
  
end
