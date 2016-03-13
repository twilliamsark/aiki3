class Sensei < ActiveRecord::Base
  include Printable
  include Searchable
  include SeedFuSerializeable

  has_many :videos
  has_many :wazas, through: :videos
end
