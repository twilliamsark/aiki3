class Waza < ActiveRecord::Base
  include Printable

  belongs_to :stance, inverse_of: :wazas
  accepts_nested_attributes_for :stance
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
    Waza.all.sort_by(&:name).each do |waza|
      next unless waza.videos.any?
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

      master[waza_name] ||= Hash.new

      waza.videos.each do |video|
        master[waza_name][video.format] ||= Array.new
        master[waza_name][video.format] << video
      end

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

  def name
    read_attribute(:name).present? ? read_attribute(:name) : technical_name
  end

  def technical_name
    return @constructed if @constructed
    @constructed = [stance, 
                    attack, 
                    attack_height, 
                    hand_applied_to, 
                    maka_komi, 
                    technique, 
                    direction, 
                    kaiten, 
                    sword, 
                    level].map{|a| a.name rescue nil}.compact.join(' ')
    @constructed
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
end
