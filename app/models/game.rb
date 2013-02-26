class Game < ActiveRecord::Base
  attr_accessible :active, :description, :team_id
  has_many :lines
  has_many :players, :through => :teams
  belongs_to :team

  def our_score()
    (lines.select { |l| l.scored? }).length
  end

  def their_score()
    (lines.select { |l| !l.scored? }).length
  end
end
