class AikiFormat < ActiveRecord::Base
  include Printable
  include Searchable
  has_many :videos
  has_many :wazas, through: :videos

  def iaido?
    to_s == 'Aiki Toho'
  end
end
