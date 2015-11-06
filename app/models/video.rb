#  http://img.youtube.com/vi/C5IWhAqQYfg/default.jpg
class Video < ActiveRecord::Base
  include Printable

  after_save :set_keywords

  belongs_to :waza
  accepts_nested_attributes_for :waza

  delegate :stance, to: :waza, allow_nil: true
  delegate :entrance, to: :waza, allow_nil: true
  delegate :attack, to: :waza, allow_nil: true
  delegate :attack_height, to: :waza, allow_nil: true
  delegate :hand_applied_to, to: :waza, allow_nil: true
  delegate :maka_komi, to: :waza, allow_nil: true
  delegate :technique, to: :waza, allow_nil: true
  delegate :direction, to: :waza, allow_nil: true
  delegate :kaiten, to: :waza, allow_nil: true
  delegate :sword, to: :waza, allow_nil: true
  delegate :level, to: :waza, allow_nil: true

  belongs_to :aiki_format
  delegate :iaido?, to: :aiki_format, allow_nil: true

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

  def self.wazas(videos)
    videos.to_a unless videos.instance_of? Array
    videos.map(&:waza)
  end

  def name
    read_attribute(:name).present? ? read_attribute(:name) : waza.name rescue 'not set'
  end

  def format
    aiki_format.to_s rescue 'Other'
  end

  def set_keywords
    waza_attribs = []

    if waza && waza.read_attribute(:name).present?
      waza_attribs = waza.name.split(" ").map(&:downcase)
    end

    single_attribs = [:stance,
                      :entrance,
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

    if kata
      waza_attribs << "iaido"
    else
      waza_attribs << "aikido"
    end

    waza_attribs << youtube_id if youtube_id

    waza_attribs << self.read_attribute(:name).downcase if self.read_attribute(:name).present?

    waza_attribs.reject!(&:blank?)
    waza_attribs.uniq!

    self.keywords = waza_attribs.join(' ').strip
    self.update_column(:keywords, keywords)
    keywords
  end
end
