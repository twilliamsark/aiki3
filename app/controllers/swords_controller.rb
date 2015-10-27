class SwordsController < ApplicationController
  before_action :set_sword, only: [:show, :edit, :update, :destroy]

  # GET /swords
  # GET /swords.json
  def index
    @swords = Sword.all
  end

  # GET /swords/1
  # GET /swords/1.json
  def show
  end

  # GET /swords/new
  def new
    @sword = Sword.new
  end

  # GET /swords/1/edit
  def edit
  end

  # POST /swords
  # POST /swords.json
  def create
    @sword = Sword.new(sword_params)

    respond_to do |format|
      if @sword.save
        format.html { redirect_to @sword, notice: 'Sword was successfully created.' }
        format.json { render action: 'show', status: :created, location: @sword }
      else
        format.html { render action: 'new' }
        format.json { render json: @sword.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /swords/1
  # PATCH/PUT /swords/1.json
  def update
    respond_to do |format|
      if @sword.update(sword_params)
        format.html { redirect_to @sword, notice: 'Sword was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @sword.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /swords/1
  # DELETE /swords/1.json
  def destroy
    @sword.destroy
    respond_to do |format|
      format.html { redirect_to swords_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sword
      @sword = Sword.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sword_params
      params.require(:sword).permit(:name, :description)
    end
end
