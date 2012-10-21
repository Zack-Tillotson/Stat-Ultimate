class Game < ActiveRecord::Base
  attr_accessible :active, :description
  has_many :lines
end
