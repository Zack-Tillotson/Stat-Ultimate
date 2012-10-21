class Line < ActiveRecord::Base
  attr_accessible :scored?
  belongs_to :game
  has_many :players
end
