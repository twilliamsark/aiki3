class KatasController < AdminController
  before_action :set_kata, only: [:show, :edit, :update, :destroy]

  # GET /katas
  # GET /katas.json
  def index
    @katas = Kata.all
  end

  # GET /katas/1
  # GET /katas/1.json
  def show
  end

  # GET /katas/new
  def new
    @kata = Kata.new
  end

  # GET /katas/1/edit
  def edit
  end

  # POST /katas
  # POST /katas.json
  def create
    @kata = Kata.new(kata_params)

    respond_to do |format|
      if @kata.save
        format.html { redirect_to @kata, notice: 'Kata was successfully created.' }
        format.json { render action: 'show', status: :created, location: @kata }
      else
        format.html { render action: 'new' }
        format.json { render json: @kata.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /katas/1
  # PATCH/PUT /katas/1.json
  def update
    respond_to do |format|
      if @kata.update(kata_params)
        format.html { redirect_to @kata, notice: 'Kata was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @kata.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /katas/1
  # DELETE /katas/1.json
  def destroy
    @kata.destroy
    respond_to do |format|
      format.html { redirect_to katas_url }
      format.json { head :no_content }
    end
  end

  private
    
    def set_kata
      @kata = Kata.find(params[:id])
    end

    def kata_params
      params.require(:kata).permit(:name)
    end
end

