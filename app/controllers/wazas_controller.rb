class WazasController < ApplicationController
  before_action :set_waza, only: [:show, :edit, :update, :destroy]

  def display
    @stance = Stance.find_by(id: params[:stance]) rescue nil if params[:stance]
    @attack = Attack.find_by(id: params[:attack]) rescue nil if params[:attack]
    @technique = Technique.find_by(id: params[:technique]) rescue nil if params[:technique]
    @format = AikiFormat.find_by(id: params[:format]) rescue nil if params[:format]
    @rank = Rank.find_by(id: params[:rank]) rescue nil if params[:rank]
    @waza = Waza.find_by(id: params[:waza_id]) rescue nil if params[:waza_id]
    @video = Video.find_by(id: params[:video_id]) rescue nil if params[:video_id]
  end

  def remote_display
    @waza = Waza.find_by(id: params[:waza_id]) rescue nil if params[:waza_id]
    @video = Video.find_by(id: params[:video_id]) rescue nil if params[:video_id]
    if @waza && @video && @video.waza.id != @waza.id
      @video = nil
    end
  end

  def master_grid
    options = {}
    if params[:stance].present?
      @stance = Stance.find_by(id: params[:stance]) rescue nil
      if @stance
        options[:stance] = @stance.name
        @stance = @stance.id
      end
    end

    if params[:attack].present?
      @attack = Attack.find_by(id: params[:attack]) rescue nil
      if @attack
        options[:attack] = @attack.name
        @attack = @attack.id
      end
    end

    if params[:technique].present?
      @technique = Technique.find_by(id: params[:technique]) rescue nil
      if @technique
        options[:technique] = @technique.name
        @technique = @technique.id
      end
    end

    if params[:format].present?
      @format = AikiFormat.find_by(id: params[:format]) rescue nil
      if @format
        options[:format] = @format.to_s
        @format = @format.id
      end
    end

    if params[:rank].present?
      @rank = Rank.find_by(id: params[:rank]) rescue nil
      if @rank
        options[:rank] = @rank.to_s
        @rank = @rank.id
      end
    end

    @master_hash = Waza.master_hash(options)
  end

  # GET /wazas
  # GET /wazas.json
  def index
    @wazas = Waza.all.order(:stance_id, :attack_id, :technique_id, :direction_id)
    render action: "index", layout: "admin"
  end

  # GET /wazas/1
  # GET /wazas/1.json
  def show
    render action: "show", layout: "admin"
  end

  # GET /wazas/new
  def new
    @waza = Waza.new
    render action: "new", layout: "admin"
  end

  # GET /wazas/1/edit
  def edit
    render action: "edit", layout: "admin"
  end

  # POST /wazas
  # POST /wazas.json
  def create
    @waza = Waza.new(waza_params)
    respond_to do |format|
      if @waza.save
        format.html { redirect_to @waza, notice: 'Waza was successfully created.' }
        format.json { render action: 'show', status: :created, location: @waza }
      else
        format.html { render action: 'new' }
        format.json { render json: @waza.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /wazas/1
  # PATCH/PUT /wazas/1.json
  def update
    respond_to do |format|
      if @waza.update(waza_params)
        format.html { redirect_to @waza, notice: 'Waza was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @waza.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /wazas/1
  # DELETE /wazas/1.json
  def destroy
    @waza.destroy
    respond_to do |format|
      format.html { redirect_to wazas_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_waza
      @waza = Waza.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def waza_params
      params.require(:waza).permit(:name, :stance_id, :attack_id, :attack_height_id, :hand_applied_to_id, :maka_komi_id, :technique_id, :direction_id, :kaiten_id, :sword_id, :level_id)
    end
end
