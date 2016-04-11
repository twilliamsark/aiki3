class VideosController < AdminController
  before_action :signed_in_user
  before_action :set_video, only: [:show, :edit, :update, :destroy]

  # GET /videos
  # GET /videos.json
  def index
    @videos = Video.has_waza.by_waza_name.page(params[:page])
  end

  def needs_review
    if params[:search].present?
      @search = params[:search]
      @videos = Video.search(@search)
    else
      @videos = Video.needs_review.page(params[:page])
    end
  end

  # GET /videos/1
  # GET /videos/1.json
  def show
  end

  # GET /videos/new
  def new
    @video = Video.new
    @video.aiki_format = AikiFormat.find_by(name: "Tiado") rescue nil
    @video.sensei = Sensei.find_by(name: "John Bollinger") rescue nil
    @video.style = Style.find_by(name: "Tachi Waza") rescue nil
    @include_waza_form = false
  end

  # GET /videos/1/edit
  def edit
    @include_waza_form = true
  end

  # POST /videos
  # POST /videos.json
  def create
    @video = Video.new(video_params)

    respond_to do |format|
      if @video.save
        format.html { redirect_to @video, notice: 'Video was successfully created.' }
        format.json { render action: 'show', status: :created, location: @video }
      else
        format.html { render action: 'new' }
        format.json { render json: @video.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /videos/1
  # PATCH/PUT /videos/1.json
  def update
    respond_to do |format|
      if @video.update_video(video_params, waza_params)
        format.html {
          if params["display"] && params["display"] == 'waza_display'
            redirect_to waza_display_path(waza_id: @video.waza.id, video_id: @video.id), notice: 'Video was successfully updated.'
          else
            redirect_to @video, notice: 'Video was successfully updated.'
          end
        }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @video.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /videos/1
  # DELETE /videos/1.json
  def destroy
    @video.destroy
    respond_to do |format|
      format.html { redirect_to videos_url }
      format.json { head :no_content }
    end
  end

  private

    def set_video
      @video = Video.find(params[:id])
    end

    def video_params
      params.require(:video).permit(:name,
                                    :waza_id,
                                    :aiki_format_id,
                                    :kata_id,
                                    :sensei_id,
                                    :style_id,
                                    :rank_id,
                                    :on_test,
                                    :needs_review,
                                    :primary,
                                    :youtube_id).reject!{|k,v| k != "name" && v.blank?}
    end

    def waza_params
      params.require(:waza).permit(:stance_id,
                                   :entrance_id,
                                   :attack_id,
                                   :attack_height_id,
                                   :hand_applied_to_id,
                                   :maka_komi_id,
                                   :technique_id,
                                   :direction_id,
                                   :kaiten_id,
                                   :sword_id,
                                   :level_id).reject!{|_,v| v.blank?}
    end
end

