class CreateWazas < ActiveRecord::Migration
  def change
    create_table :wazas do |t|
      t.string :name
      t.references :stance, index: true
      t.references :attack, index: true
      t.references :attack_height, index: true
      t.references :hand_applied_to, index: true
      t.references :maka_komi, index: true
      t.references :technique, index: true
      t.references :direction, index: true
      t.references :kaiten, index: true
      t.references :sword, index: true
      t.references :level, index: true

      t.timestamps
    end
  end
end
