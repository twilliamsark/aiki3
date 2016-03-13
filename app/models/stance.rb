class Stance < ActiveRecord::Base
  include WazaAttribute
  include Searchable
  include SeedFuSerializeable

  has_many :wazas, inverse_of: :stance
  has_many :videos, through: :wazas
end
