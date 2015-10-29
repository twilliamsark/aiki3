class AddKataToVideo < ActiveRecord::Migration
  def change
    add_column :videos, :kata_id, :integer
    add_index :videos, :kata_id
  end
end
