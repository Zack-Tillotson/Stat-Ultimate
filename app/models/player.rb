class Player < ActiveRecord::Base
  attr_accessible :name
  attr_accessible :team_id
  belongs_to :team
  has_and_belongs_to_many :lines, :join_table => "line_players"

  def points_played(options = {})
    (lines.select { |l| 
      game_matches = (!options.has_key?(:game_id) or options[:game_id] == nil or options[:game_id] == l.game_id)
      score_matches = (!options.has_key?(:scored) or options[:scored] == nil or options[:scored] == l.scored)
      received_matches = (!options.has_key?(:received) or options[:received] == nil or options[:received] == l.received)
      game_matches and score_matches and received_matches
    }).count
  end

end
