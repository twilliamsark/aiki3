module Searchable
  extend ActiveSupport::Concern

  included do
    after_save :update_video_keywords
  end

  def update_video_keywords
    videos.distinct.each(&:set_keywords)
  end
end