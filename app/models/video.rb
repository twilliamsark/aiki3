#  http://img.youtube.com/vi/C5IWhAqQYfg/default.jpg
class Video < ActiveRecord::Base
  include WazaAttribute

  belongs_to :waza
  accepts_nested_attributes_for :waza
  belongs_to :aiki_format
  accepts_nested_attributes_for :aiki_format
  belongs_to :rank
  accepts_nested_attributes_for :rank

  belongs_to :sensei
  belongs_to :style

  def name
    read_attribute(:name).present? ? read_attribute(:name) : waza.name
  end
end
