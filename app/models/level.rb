class Level < ActiveRecord::Base
  include WazaAttribute
  include Searchable
  include SeedFuSerializeable

  has_many :wazas, inverse_of: :level
  has_many :videos, through: :wazas
end
