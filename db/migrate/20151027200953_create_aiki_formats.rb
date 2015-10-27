class CreateAikiFormats < ActiveRecord::Migration
  def change
    create_table :aiki_formats do |t|
      t.string :name
      t.string :description

      t.timestamps
    end
  end
end
