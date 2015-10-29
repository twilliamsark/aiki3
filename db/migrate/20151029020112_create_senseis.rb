class CreateSenseis < ActiveRecord::Migration
  def change
    create_table :senseis do |t|
      t.string :name

      t.timestamps
    end
  end
end
