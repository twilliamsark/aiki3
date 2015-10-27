class CreateMakaKomis < ActiveRecord::Migration
  def change
    create_table :maka_komis do |t|
      t.string :name
      t.string :description

      t.timestamps
    end
  end
end
