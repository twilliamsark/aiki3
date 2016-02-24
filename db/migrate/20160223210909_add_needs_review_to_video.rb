class AddNeedsReviewToVideo < ActiveRecord::Migration
  def change
    add_column :videos, :needs_review, :boolean
  end
end
