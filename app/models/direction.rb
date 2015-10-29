class Direction < ActiveRecord::Base
  include WazaAttribute
  include Searchable
  has_many :wazas, inverse_of: :direction
  has_many :videos, through: :wazas
end
