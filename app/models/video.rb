#  http://img.youtube.com/vi/C5IWhAqQYfg/default.jpg
class Video < ActiveRecord::Base
  include Printable

  after_save :set_keywords

  belongs_to :waza
  accepts_nested_attributes_for :waza

  delegate :stance, to: :waza
  delegate :attack, to: :waza
  delegate :attack_height, to: :waza
  delegate :hand_applied_to, to: :waza
  delegate :maka_komi, to: :waza
  delegate :technique, to: :waza
  delegate :direction, to: :waza
  delegate :kaiten, to: :waza
  delegate :sword, to: :waza
  delegate :level, to: :waza

  belongs_to :aiki_format
  belongs_to :kata
  belongs_to :rank
  belongs_to :sensei
  belongs_to :style

  def self.search(keyword)
    results = []
    if keyword.present?
      results = where('keywords like ?', "%#{keyword.downcase}%")
      results = results.to_a
      if keyword.downcase == 'ikkyo'
        results.to_a.reject!{|r| r.keywords.include?('nikkyo') }
      end
    end
    results
  end

  def name
    read_attribute(:name).present? ? read_attribute(:name) : waza.name
  end

  def set_keywords
    waza_attribs = []

    if waza.read_attribute(:name).present?
      waza_attribs = waza.name.split(" ").map(&:downcase)
    end

    single_attribs = [:stance,
                      :attack, 
                      :attack_height,
                      :hand_applied_to,
                      :maka_komi,
                      :technique, 
                      :direction,
                      :kaiten,
                      :sword,
                      :level,
                      :aiki_format,
                      :kata,
                      :rank,
                      :sensei,
                      :style]

    single_attribs.each do |attrib|
      waza_attribs << self.send(attrib, true).to_s.downcase
    end

    waza_attribs.reject!(&:blank?)
    waza_attribs.uniq!

    self.keywords = waza_attribs.join(' ').strip
    self.update_column(:keywords, keywords)
    keywords
  end
end
