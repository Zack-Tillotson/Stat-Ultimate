class Player < ActiveRecord::Base
  attr_accessible :name
  attr_accessible :team_id
  belongs_to :team
  has_many :line_players
  has_many :lines, :through => :line_players

  def points_played(options = {})
    (lines.select { |l| 
      game_matches = (!options.has_key?(:game_id) or options[:game_id] == nil or options[:game_id] == l.game_id)
      score_matches = (!options.has_key?(:scored) or options[:scored] == nil or options[:scored] == l.scored)
      received_matches = (!options.has_key?(:received) or options[:received] == nil or options[:received] == l.received)
      game_matches and score_matches and received_matches
    }).count
  end

  def throw_aways(options = {})
    line_players.reduce(0) { |sum, l| 
      game_matches = (!options.has_key?(:game_id) or options[:game_id] == nil or options[:game_id] == l.line.game_id)
      score_matches = (!options.has_key?(:scored) or options[:scored] == nil or options[:scored] == l.line.scored)
      received_matches = (!options.has_key?(:received) or options[:received] == nil or options[:received] == l.line.received)
      if game_matches and score_matches and received_matches
        sum + l.throwaway
      else
        sum
      end
    }
  end

  def drops(options = {})
    line_players.reduce(0) { |sum, l| 
      game_matches = (!options.has_key?(:game_id) or options[:game_id] == nil or options[:game_id] == l.line.game_id)
      score_matches = (!options.has_key?(:scored) or options[:scored] == nil or options[:scored] == l.line.scored)
      received_matches = (!options.has_key?(:received) or options[:received] == nil or options[:received] == l.line.received)
      if game_matches and score_matches and received_matches
        sum + l.drop
      else
        sum
      end
    }
  end

  def take_aways(options = {})
    line_players.reduce(0) { |sum, l| 
      game_matches = (!options.has_key?(:game_id) or options[:game_id] == nil or options[:game_id] == l.line.game_id)
      score_matches = (!options.has_key?(:scored) or options[:scored] == nil or options[:scored] == l.line.scored)
      received_matches = (!options.has_key?(:received) or options[:received] == nil or options[:received] == l.line.received)
      if game_matches and score_matches and received_matches
        sum + l.takeaway
      else
        sum
      end
    }
  end
end
