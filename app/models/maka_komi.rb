class MakaKomi < ActiveRecord::Base
  include WazaAttribute
  include Searchable
  has_many :wazas, inverse_of: :maka_komi
  has_many :videos, through: :wazas
end
