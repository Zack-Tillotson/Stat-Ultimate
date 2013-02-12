class LinePlayer < ActiveRecord::Base
  belongs_to :line
  belongs_to :player
end
