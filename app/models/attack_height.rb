class AttackHeight < ActiveRecord::Base
  include WazaAttribute
  include Searchable
  has_many :wazas, inverse_of: :attack_height
  has_many :videos, through: :wazas
end
