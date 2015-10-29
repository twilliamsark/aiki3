class VideosController < InheritedResources::Base

  private

    def video_params
      params.require(:video).permit(:name, :waza_id, :aiki_format_id, :kata_id, :sensei_id, :style_id, :rank_id, :on_test, :youtube_id)
    end
end

