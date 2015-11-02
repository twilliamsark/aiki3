class MakaKomisController < AdminController
  before_action :set_maka_komi, only: [:show, :edit, :update, :destroy]

  # GET /maka_komis
  # GET /maka_komis.json
  def index
    @maka_komis = MakaKomi.all
  end

  # GET /maka_komis/1
  # GET /maka_komis/1.json
  def show
  end

  # GET /maka_komis/new
  def new
    @maka_komi = MakaKomi.new
  end

  # GET /maka_komis/1/edit
  def edit
  end

  # POST /maka_komis
  # POST /maka_komis.json
  def create
    @maka_komi = MakaKomi.new(maka_komi_params)

    respond_to do |format|
      if @maka_komi.save
        format.html { redirect_to @maka_komi, notice: 'Maka komi was successfully created.' }
        format.json { render action: 'show', status: :created, location: @maka_komi }
      else
        format.html { render action: 'new' }
        format.json { render json: @maka_komi.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /maka_komis/1
  # PATCH/PUT /maka_komis/1.json
  def update
    respond_to do |format|
      if @maka_komi.update(maka_komi_params)
        format.html { redirect_to @maka_komi, notice: 'Maka komi was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @maka_komi.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /maka_komis/1
  # DELETE /maka_komis/1.json
  def destroy
    @maka_komi.destroy
    respond_to do |format|
      format.html { redirect_to maka_komis_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_maka_komi
      @maka_komi = MakaKomi.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def maka_komi_params
      params.require(:maka_komi).permit(:name, :description)
    end
end
