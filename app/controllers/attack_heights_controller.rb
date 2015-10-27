class AttackHeightsController < ApplicationController
  before_action :set_attack_height, only: [:show, :edit, :update, :destroy]

  # GET /attack_heights
  # GET /attack_heights.json
  def index
    @attack_heights = AttackHeight.all
  end

  # GET /attack_heights/1
  # GET /attack_heights/1.json
  def show
  end

  # GET /attack_heights/new
  def new
    @attack_height = AttackHeight.new
  end

  # GET /attack_heights/1/edit
  def edit
  end

  # POST /attack_heights
  # POST /attack_heights.json
  def create
    @attack_height = AttackHeight.new(attack_height_params)

    respond_to do |format|
      if @attack_height.save
        format.html { redirect_to @attack_height, notice: 'Attack height was successfully created.' }
        format.json { render action: 'show', status: :created, location: @attack_height }
      else
        format.html { render action: 'new' }
        format.json { render json: @attack_height.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /attack_heights/1
  # PATCH/PUT /attack_heights/1.json
  def update
    respond_to do |format|
      if @attack_height.update(attack_height_params)
        format.html { redirect_to @attack_height, notice: 'Attack height was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @attack_height.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /attack_heights/1
  # DELETE /attack_heights/1.json
  def destroy
    @attack_height.destroy
    respond_to do |format|
      format.html { redirect_to attack_heights_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_attack_height
      @attack_height = AttackHeight.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def attack_height_params
      params.require(:attack_height).permit(:name, :description)
    end
end
