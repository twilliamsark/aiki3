class MakaKomi < ActiveRecord::Base
  include WazaAttribute
  include Searchable
  include SeedFuSerializeable

  has_many :wazas, inverse_of: :maka_komi
  has_many :videos, through: :wazas
end
