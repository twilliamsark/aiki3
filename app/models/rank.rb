class Rank < ActiveRecord::Base
  include WazaAttribute

  has_many :videos
end
