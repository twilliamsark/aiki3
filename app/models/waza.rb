class Waza < ActiveRecord::Base
  include Printable
  include Searchable
  include SeedFuSerializeable

  before_save :set_waza_name

  belongs_to :stance, inverse_of: :wazas
  accepts_nested_attributes_for :stance

  belongs_to :entrance, inverse_of: :wazas
  accepts_nested_attributes_for :entrance

  belongs_to :attack, inverse_of: :wazas
  accepts_nested_attributes_for :attack

  belongs_to :attack_height, inverse_of: :wazas
  accepts_nested_attributes_for :attack_height

  belongs_to :hand_applied_to, inverse_of: :wazas
  accepts_nested_attributes_for :hand_applied_to

  belongs_to :maka_komi, inverse_of: :wazas
  accepts_nested_attributes_for :maka_komi

  belongs_to :technique, inverse_of: :wazas
  accepts_nested_attributes_for :technique

  belongs_to :direction, inverse_of: :wazas
  accepts_nested_attributes_for :direction

  belongs_to :kaiten, inverse_of: :wazas
  accepts_nested_attributes_for :kaiten

  belongs_to :sword, inverse_of: :wazas
  accepts_nested_attributes_for :sword

  belongs_to :level, inverse_of: :wazas
  accepts_nested_attributes_for :level

  has_many :videos
  has_many :aiki_formats, through: :videos
  has_many :ranks, through: :videos

  scope :for_stance, ->(stance) { where(stance: stance) }
  scope :for_entrance, ->(entrance) { where(entrance: entrance) }
  scope :for_attack, ->(attack) { where(attack: attack) }
  scope :for_attack_height, ->(attack_height) { where(attack_height: attack_height) }
  scope :for_hand_applied_to, ->(hand_applied_to) { where(hand_applied_to: hand_applied_to) }
  scope :for_maka_komi, ->(maka_komi) { where(maka_komi: maka_komi) }
  scope :for_technique, ->(technique) { where(technique: technique) }
  scope :for_direction, ->(direction) { where(direction: direction) }
  scope :for_kaiten, ->(kaiten) { where(kaiten: kaiten) }
  scope :for_sword, ->(sword) { where(sword: sword) }
  scope :for_level, ->(level) { where(level: level) }

  validates :technique, presence: true

  def to_h
    attributes.select{|k,_| !%w(id created_at updated_at name).include?(k)}
  end

  def self.wazas_hash(wazas)
    h = {}
    wazas.each do |waza|
      name, whash = waza.waza_hash
      h[name] = whash
    end
    h
  end

  def self.master_hash(options={})
    master = Hash.new
    duplicates = Hash.new

    if options[:search].present?
      wazas = Video.wazas(Video.search(options[:search])) rescue []
    else
      wazas = Waza.all
    end

    wazas.sort_by(&:name).each do |waza|
      next unless waza.videos.has_aiki_format.any?
      next unless include_based_on?(waza, options)
      next if options[:format].present? && !include_format?(waza.aiki_formats.map(&:name), options)
      next if options[:rank].present? && !include_rank?(waza.ranks.map(&:name), options)

      waza_name = waza.name
      includes = []
      unless waza_name.include? waza.stance.to_s
        includes << waza.stance.to_s
      end
      unless waza_name.include? waza.attack.to_s
        includes << waza.attack.to_s
      end
      unless waza_name.include? waza.technique.to_s
        includes << waza.technique.to_s
      end
      if includes.any?
        waza_name += " (#{includes.join(', ')})"
      end

      master[waza] ||= Hash.new

      if options[:search].present?
        master[waza][:sub_name] = waza.technical_name
      else
        if duplicates[waza_name]
          master[waza][:sub_name] = waza.technical_name
          unless master[duplicates[waza_name]][:sub_name].present?
            master[duplicates[waza_name]][:sub_name] = duplicates[waza_name].technical_name
          end
        else
          duplicates[waza_name] = waza
        end
      end

      master[waza][:name] = waza_name
      waza.videos.each do |video|
        next if video.needs_review?
        next if options[:format] && options[:format] != video.format
        next if options[:rank] && options[:rank] != video.rank.name
        next if options[:stance] && options[:stance] != video.stance.name
        next if options[:attack] && options[:attack] != video.attack.name
        next if options[:technique] && options[:technique] != video.technique.name
        master[waza][:videos] ||= Hash.new
        master[waza][:videos][video.format] ||= Array.new
        master[waza][:videos][video.format] << video
      end
      master.delete(waza) if master[waza][:videos].nil? || master[waza][:videos].empty?
    end

    master
  end

  def self.include_format?(formats, options)
    return true unless options[:format].present? && formats.any?
    formats.include? options[:format]
  end

  def self.include_rank?(ranks, options)
    return true unless options[:rank].present? && ranks.any?
    ranks.include? options[:rank]
  end

  def self.include_based_on?(waza, options)
    return true if options.empty?

    technique_include = options[:technique].present? ? false : true
    if options[:technique].present? && waza.technique
      technique_include = options[:technique] == waza.technique.name
    end

    stance_include = options[:stance].present? ? false : true
    if options[:stance].present? && waza.stance
      stance_include = options[:stance] == waza.stance.name
    end

    attack_include = options[:attack].present? ? false : true
    if options[:attack].present? && waza.attack
      attack_include = options[:attack] == waza.attack.name
    end

    return technique_include && stance_include && attack_include
  end

  def formats
    aiki_formats
  end

  def technical_name
    @tech_name ||= [stance,
                    entrance,
                    attack,
                    attack_height,
                    hand_applied_to,
                    maka_komi,
                    technique,
                    direction,
                    kaiten,
                    sword,
                    level].map{|a| a.name rescue nil}.compact.join(' ')
  end

  def short_name
    @short_tech_name ||= [stance,
                          technique,
                          direction].map{|a| a.name rescue nil}.compact.join(' ')
  end

  def inspect
    "<#{identify(:id, :technique)}(#{name})>"
  end

  def waza_hash
    h = {
      waza: self,
      formats: {}
    }

    videos.each do |v|
      h[:formats][v.format] ||= []
      h[:formats][v.format] << v
    end

    [name, h]
  end

  def set_waza_name
    self.name = short_name unless name.present?
  end
end
