class Style < ActiveRecord::Base
  include WazaAttribute
  has_many :videos
end
