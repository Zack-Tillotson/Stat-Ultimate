class Team < ActiveRecord::Base
  attr_accessible :name, :players_attributes
  has_many :games
  belongs_to :game
  has_many :players
  accepts_nested_attributes_for :players
  before_save :mark_children_for_removal

  def mark_children_for_removal
    players.each do |player|
      player.mark_for_destruction if player.name.blank?
    end
  end
    
end
