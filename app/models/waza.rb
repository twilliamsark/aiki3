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

  def self.wazas_hash(wazas)
    h = {}

    wazas.each do |waza|
      name, whash = waza.waza_hash
      h[name] = whash
    end

    h
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
