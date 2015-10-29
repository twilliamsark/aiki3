class Attack < ActiveRecord::Base
  include WazaAttribute
  include Searchable
  has_many :wazas, inverse_of: :attack
  has_many :videos, through: :wazas
end
