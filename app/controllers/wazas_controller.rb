class WazasController < ApplicationController
  before_action :set_waza, only: [:show, :edit, :update, :destroy]

  # GET /wazas
  # GET /wazas.json
  def index
    @wazas = Waza.all.order(:stance_id, :attack_id, :technique_id, :direction_id)
  end

  # GET /wazas/1
  # GET /wazas/1.json
  def show
  end

  # GET /wazas/new
  def new
    @waza = Waza.new
  end

  # GET /wazas/1/edit
  def edit
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
