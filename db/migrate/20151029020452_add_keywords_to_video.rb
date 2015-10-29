class AddKeywordsToVideo < ActiveRecord::Migration
  def change
    add_column :videos, :keywords, :text
  end
end
