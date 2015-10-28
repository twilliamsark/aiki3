class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.string :name
      t.references :waza, index: true
      t.references :aiki_format, index: true
      t.references :rank, index: true
      t.boolean :on_test, default: false
      t.boolean :primary, default: false
      t.string :youtube_id

      t.timestamps
    end
  end
end
