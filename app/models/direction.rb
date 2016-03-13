class Direction < ActiveRecord::Base
  include WazaAttribute
  include Searchable
  include SeedFuSerializeable

  has_many :wazas, inverse_of: :direction
  has_many :videos, through: :wazas
end
