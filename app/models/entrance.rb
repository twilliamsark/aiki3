class Entrance < ActiveRecord::Base
  include WazaAttribute
  include Searchable
  has_many :wazas, inverse_of: :stance
  has_many :videos, through: :wazas
end
