class HandAppliedTosController < AdminController
  before_action :set_hand_applied_to, only: [:show, :edit, :update, :destroy]

  # GET /hand_applied_tos
  # GET /hand_applied_tos.json
  def index
    @hand_applied_tos = HandAppliedTo.all
  end

  # GET /hand_applied_tos/1
  # GET /hand_applied_tos/1.json
  def show
  end

  # GET /hand_applied_tos/new
  def new
    @hand_applied_to = HandAppliedTo.new
  end

  # GET /hand_applied_tos/1/edit
  def edit
  end

  # POST /hand_applied_tos
  # POST /hand_applied_tos.json
  def create
    @hand_applied_to = HandAppliedTo.new(hand_applied_to_params)

    respond_to do |format|
      if @hand_applied_to.save
        format.html { redirect_to @hand_applied_to, notice: 'Hand applied to was successfully created.' }
        format.json { render action: 'show', status: :created, location: @hand_applied_to }
      else
        format.html { render action: 'new' }
        format.json { render json: @hand_applied_to.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /hand_applied_tos/1
  # PATCH/PUT /hand_applied_tos/1.json
  def update
    respond_to do |format|
      if @hand_applied_to.update(hand_applied_to_params)
        format.html { redirect_to @hand_applied_to, notice: 'Hand applied to was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @hand_applied_to.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /hand_applied_tos/1
  # DELETE /hand_applied_tos/1.json
  def destroy
    @hand_applied_to.destroy
    respond_to do |format|
      format.html { redirect_to hand_applied_tos_url }
      format.json { head :no_content }
    end
  end

  private
    
    def set_hand_applied_to
      @hand_applied_to = HandAppliedTo.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def hand_applied_to_params
      params.require(:hand_applied_to).permit(:name, :description)
    end
end
