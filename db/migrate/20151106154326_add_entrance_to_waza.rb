class AddEntranceToWaza < ActiveRecord::Migration
  def change
    add_reference :wazas, :entrance, index: true
  end
end
