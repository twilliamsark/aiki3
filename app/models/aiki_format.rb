class AikiFormat < ActiveRecord::Base
  include Printable
  include Searchable
  has_many :videos
  has_many :wazas, through: :videos
end
