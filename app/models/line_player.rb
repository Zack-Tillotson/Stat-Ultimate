class LinePlayer < ActiveRecord::Base
  attr_accessible :throwaway, :drop, :takeaway
  belongs_to :line
  belongs_to :player
end
