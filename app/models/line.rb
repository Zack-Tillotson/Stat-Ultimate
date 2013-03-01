class Line < ActiveRecord::Base
  attr_accessible :scored, :active, :game_id, :players, :player_ids, :received
  belongs_to :game
  has_many :line_players
  has_many :players, :through => :line_players

  def prepopulate_received(game)
    game || return
    self.received = (game.lines.length == 0 ? false : !game.lines.at(-1).scored)
  end
  
end
