class Waza < ActiveRecord::Base
  include WazaAttribute

  belongs_to :stance
  accepts_nested_attributes_for :stance
  belongs_to :attack
  accepts_nested_attributes_for :attack
  belongs_to :attack_height
  accepts_nested_attributes_for :attack_height
  belongs_to :hand_applied_to
  accepts_nested_attributes_for :hand_applied_to
  belongs_to :maka_komi
  accepts_nested_attributes_for :maka_komi
  belongs_to :technique
  accepts_nested_attributes_for :technique
  belongs_to :direction
  accepts_nested_attributes_for :direction
  belongs_to :kaiten
  accepts_nested_attributes_for :kaiten
  belongs_to :sword
  accepts_nested_attributes_for :sword
  belongs_to :level
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
end
