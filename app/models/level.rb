class Level < ActiveRecord::Base
  include WazaAttribute
  include Searchable
  has_many :wazas, inverse_of: :level
  has_many :videos, through: :wazas
end
