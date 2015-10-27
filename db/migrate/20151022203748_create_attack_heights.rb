class CreateAttackHeights < ActiveRecord::Migration
  def change
    create_table :attack_heights do |t|
      t.string :name
      t.string :description

      t.timestamps
    end
  end
end
