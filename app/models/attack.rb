class Attack < ActiveRecord::Base
  include WazaAttribute
  include Searchable
  include SeedFuSerializeable

  has_many :wazas, inverse_of: :attack
  has_many :videos, through: :wazas
end
