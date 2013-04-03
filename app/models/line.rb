class Line < ActiveRecord::Base
  attr_accessible :scored, :active, :game_id, :players, :player_ids, :received
  belongs_to :game
  has_many :line_players
  has_many :players, :through => :line_players

  def prepopulate_received(game)
    game || return
    previous_line = game.lines.at(-1)
    self.received = (game.lines.length == 0 ? false : !previous_line.scored)
    previous_line.players.each do |p|
      puts "Adding #{p}, count #{self.players.count}"
      self.players << p
    end
  end
  
end
