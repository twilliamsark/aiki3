class Technique < ActiveRecord::Base
  include WazaAttribute
  include Searchable
  has_many :wazas, inverse_of: :technique
  has_many :videos, through: :wazas
end
