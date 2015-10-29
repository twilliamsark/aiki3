class AddSenseiAndStyleToVideo < ActiveRecord::Migration
  def change
    add_column :videos, :sensei_id, :integer
    add_column :videos, :style_id, :integer
    add_index :videos, :sensei_id
    add_index :videos, :style_id
  end
end
