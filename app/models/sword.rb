class Sword < ActiveRecord::Base
  include WazaAttribute
  include Searchable
  has_many :wazas, inverse_of: :sword
  has_many :videos, through: :wazas
end
