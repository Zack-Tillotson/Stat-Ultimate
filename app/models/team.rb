class Team < ActiveRecord::Base
  attr_accessible :name
  has_many :players
  has_many :games
  belongs_to :game
end
