class CreateKaitens < ActiveRecord::Migration
  def change
    create_table :kaitens do |t|
      t.string :name
      t.string :description

      t.timestamps
    end
  end
end
