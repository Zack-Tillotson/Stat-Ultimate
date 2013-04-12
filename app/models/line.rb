class Line < ActiveRecord::Base
  attr_accessible :scored, :active, :game_id, :players, :player_ids, :received
  belongs_to :game
  has_many :line_players
  has_many :players, :through => :line_players
  accepts_nested_attributes_for :line_players

  def self.createFromGame(game)
    previous_line = game.lines.at(-1)

    l = Line.new
    l.received = (game.lines.length == 0 ? false : !previous_line.scored)

    if previous_line
      l.players << previous_line.players
      l.line_players << previous_line.line_players
    end
    l
  end
  
end
