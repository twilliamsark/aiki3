class Kata < ActiveRecord::Base
  include Printable
  include Searchable
  self.table_name = "katas"
  has_many :videos
  has_many :wazas, through: :videos
end
