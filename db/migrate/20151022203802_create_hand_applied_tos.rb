class CreateHandAppliedTos < ActiveRecord::Migration
  def change
    create_table :hand_applied_tos do |t|
      t.string :name
      t.string :description

      t.timestamps
    end
  end
end
