class EntrancesController < AdminController
  before_action :set_entrance, only: [:show, :edit, :update, :destroy]

  # GET /entrances
  # GET /entrances.json
  def index
    @entrances = Entrance.all
  end

  # GET /entrances/1
  # GET /entrances/1.json
  def show
  end

  # GET /entrances/new
  def new
    @entrance = Entrance.new
  end

  # GET /entrances/1/edit
  def edit
  end

  # POST /entrances
  # POST /entrances.json
  def create
    @entrance = Entrance.new(entrance_params)

    respond_to do |format|
      if @entrance.save
        format.html { redirect_to @entrance, notice: 'Entrance was successfully created.' }
        format.json { render action: 'show', status: :created, location: @entrance }
      else
        format.html { render action: 'new' }
        format.json { render json: @entrance.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /entrances/1
  # PATCH/PUT /entrances/1.json
  def update
    respond_to do |format|
      if @entrance.update(entrance_params)
        format.html { redirect_to @entrance, notice: 'Entrance was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @entrance.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /entrances/1
  # DELETE /entrances/1.json
  def destroy
    @entrance.destroy
    respond_to do |format|
      format.html { redirect_to entrances_url }
      format.json { head :no_content }
    end
  end

  private

    def set_entrance
      @entrance = Entrance.find(params[:id])
    end

    def entrance_params
      params.require(:entrance).permit(:name, :description)
    end
end

