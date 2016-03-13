class Kaiten < ActiveRecord::Base
  include WazaAttribute
  include Searchable
  include SeedFuSerializeable

  has_many :wazas, inverse_of: :kaiten
  has_many :videos, through: :wazas
end
