class Technique < ActiveRecord::Base
  include WazaAttribute
  include Searchable
  include SeedFuSerializeable

  has_many :wazas, inverse_of: :technique
  has_many :videos, through: :wazas
end
