class StancesController < AdminController
  before_action :set_stance, only: [:show, :edit, :update, :destroy]

  # GET /stances
  # GET /stances.json
  def index
    @stances = Stance.all
  end

  # GET /stances/1
  # GET /stances/1.json
  def show
  end

  # GET /stances/new
  def new
    @stance = Stance.new
  end

  # GET /stances/1/edit
  def edit
  end

  # POST /stances
  # POST /stances.json
  def create
    @stance = Stance.new(stance_params)

    respond_to do |format|
      if @stance.save
        format.html { redirect_to @stance, notice: 'Stance was successfully created.' }
        format.json { render action: 'show', status: :created, location: @stance }
      else
        format.html { render action: 'new' }
        format.json { render json: @stance.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /stances/1
  # PATCH/PUT /stances/1.json
  def update
    respond_to do |format|
      if @stance.update(stance_params)
        format.html { redirect_to @stance, notice: 'Stance was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @stance.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stances/1
  # DELETE /stances/1.json
  def destroy
    @stance.destroy
    respond_to do |format|
      format.html { redirect_to stances_url }
      format.json { head :no_content }
    end
  end

  private
    
    def set_stance
      @stance = Stance.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def stance_params
      params.require(:stance).permit(:name, :description)
    end
end
