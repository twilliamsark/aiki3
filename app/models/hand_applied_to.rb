class HandAppliedTo < ActiveRecord::Base
  include WazaAttribute
  include Searchable
  has_many :wazas, inverse_of: :hand_applied_to
  has_many :videos, through: :wazas
end
