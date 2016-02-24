class TechniquesController < AdminController
  before_action :set_technique, only: [:show, :edit, :update, :destroy]

  # GET /techniques
  # GET /techniques.json
  def index
    @techniques = Technique.order(:name)
  end

  # GET /techniques/1
  # GET /techniques/1.json
  def show
  end

  # GET /techniques/new
  def new
    @technique = Technique.new
  end

  # GET /techniques/1/edit
  def edit
  end

  # POST /techniques
  # POST /techniques.json
  def create
    @technique = Technique.new(technique_params)

    respond_to do |format|
      if @technique.save
        format.html { redirect_to @technique, notice: 'Technique was successfully created.' }
        format.json { render action: 'show', status: :created, location: @technique }
      else
        format.html { render action: 'new' }
        format.json { render json: @technique.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /techniques/1
  # PATCH/PUT /techniques/1.json
  def update
    respond_to do |format|
      if @technique.update(technique_params)
        format.html { redirect_to @technique, notice: 'Technique was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @technique.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /techniques/1
  # DELETE /techniques/1.json
  def destroy
    @technique.destroy
    respond_to do |format|
      format.html { redirect_to techniques_url }
      format.json { head :no_content }
    end
  end

  private

    def set_technique
      @technique = Technique.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def technique_params
      params.require(:technique).permit(:name, :description)
    end
end
