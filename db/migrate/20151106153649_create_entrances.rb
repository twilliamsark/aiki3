class CreateEntrances < ActiveRecord::Migration
  def change
    create_table :entrances do |t|
      t.string :name
      t.string :description

      t.timestamps
    end
  end
end
