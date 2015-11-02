class SenseisController < AdminController
  before_action :set_sensei, only: [:show, :edit, :update, :destroy]

  # GET /senseis
  # GET /senseis.json
  def index
    @senseis = Sensei.all
  end

  # GET /senseis/1
  # GET /senseis/1.json
  def show
  end

  # GET /senseis/new
  def new
    @sensei = Sensei.new
  end

  # GET /senseis/1/edit
  def edit
  end

  # POST /senseis
  # POST /senseis.json
  def create
    @sensei = Sensei.new(sensei_params)

    respond_to do |format|
      if @sensei.save
        format.html { redirect_to @sensei, notice: 'Sensei was successfully created.' }
        format.json { render action: 'show', status: :created, location: @sensei }
      else
        format.html { render action: 'new' }
        format.json { render json: @sensei.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /senseis/1
  # PATCH/PUT /senseis/1.json
  def update
    respond_to do |format|
      if @sensei.update(sensei_params)
        format.html { redirect_to @sensei, notice: 'Sensei was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @sensei.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /senseis/1
  # DELETE /senseis/1.json
  def destroy
    @sensei.destroy
    respond_to do |format|
      format.html { redirect_to senseis_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sensei
      @sensei = Sensei.find(params[:id])
    end

    def sensei_params
      params.require(:sensei).permit(:name)
    end
end

