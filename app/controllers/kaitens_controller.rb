class KaitensController < ApplicationController
  before_action :set_kaiten, only: [:show, :edit, :update, :destroy]

  # GET /kaitens
  # GET /kaitens.json
  def index
    @kaitens = Kaiten.all
  end

  # GET /kaitens/1
  # GET /kaitens/1.json
  def show
  end

  # GET /kaitens/new
  def new
    @kaiten = Kaiten.new
  end

  # GET /kaitens/1/edit
  def edit
  end

  # POST /kaitens
  # POST /kaitens.json
  def create
    @kaiten = Kaiten.new(kaiten_params)

    respond_to do |format|
      if @kaiten.save
        format.html { redirect_to @kaiten, notice: 'Kaiten was successfully created.' }
        format.json { render action: 'show', status: :created, location: @kaiten }
      else
        format.html { render action: 'new' }
        format.json { render json: @kaiten.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /kaitens/1
  # PATCH/PUT /kaitens/1.json
  def update
    respond_to do |format|
      if @kaiten.update(kaiten_params)
        format.html { redirect_to @kaiten, notice: 'Kaiten was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @kaiten.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /kaitens/1
  # DELETE /kaitens/1.json
  def destroy
    @kaiten.destroy
    respond_to do |format|
      format.html { redirect_to kaitens_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_kaiten
      @kaiten = Kaiten.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def kaiten_params
      params.require(:kaiten).permit(:name, :description)
    end
end
