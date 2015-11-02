class AikiFormatsController < AdminController
  before_action :set_aiki_format, only: [:show, :edit, :update, :destroy]

  # GET /aiki_formats
  # GET /aiki_formats.json
  def index
    @aiki_formats = AikiFormat.all
  end

  # GET /aiki_formats/1
  # GET /aiki_formats/1.json
  def show
  end

  # GET /aiki_formats/new
  def new
    @aiki_format = AikiFormat.new
  end

  # GET /aiki_formats/1/edit
  def edit
  end

  # POST /aiki_formats
  # POST /aiki_formats.json
  def create
    @aiki_format = AikiFormat.new(aiki_format_params)

    respond_to do |format|
      if @aiki_format.save
        format.html { redirect_to @aiki_format, notice: 'Format was successfully created.' }
        format.json { render action: 'show', status: :created, location: @aiki_format }
      else
        format.html { render action: 'new' }
        format.json { render json: @aiki_format.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /aiki_formats/1
  # PATCH/PUT /aiki_formats/1.json
  def update
    respond_to do |format|
      if @aiki_format.update(aiki_format_params)
        format.html { redirect_to @aiki_format, notice: 'Format was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @aiki_format.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /aiki_formats/1
  # DELETE /aiki_formats/1.json
  def destroy
    @aiki_format.destroy
    respond_to do |format|
      format.html { redirect_to aiki_formats_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_aiki_format
      @aiki_format = AikiFormat.find(params[:id])
    end

    def aiki_format_params
      params.require(:aiki_format).permit(:name, :description)
    end
end

