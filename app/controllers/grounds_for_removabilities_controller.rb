class GroundsForRemovabilitiesController < ApplicationController
  before_action :set_grounds_for_removability, only: [:show, :edit, :update, :destroy]

  # GET /grounds_for_removabilities
  # GET /grounds_for_removabilities.json
  def index
    @grounds_for_removabilities = GroundsForRemovability.all
  end

  # GET /grounds_for_removabilities/1
  # GET /grounds_for_removabilities/1.json
  def show
  end

  # GET /grounds_for_removabilities/new
  def new
    @grounds_for_removability = GroundsForRemovability.new
  end

  # GET /grounds_for_removabilities/1/edit
  def edit
  end

  # POST /grounds_for_removabilities
  # POST /grounds_for_removabilities.json
  def create
    @grounds_for_removability = GroundsForRemovability.new(grounds_for_removability_params)

    respond_to do |format|
      if @grounds_for_removability.save
        format.html { redirect_to @grounds_for_removability, notice: 'Grounds for removability was successfully created.' }
        format.json { render :show, status: :created, location: @grounds_for_removability }
      else
        format.html { render :new }
        format.json { render json: @grounds_for_removability.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /grounds_for_removabilities/1
  # PATCH/PUT /grounds_for_removabilities/1.json
  def update
    respond_to do |format|
      if @grounds_for_removability.update(grounds_for_removability_params)
        format.html { redirect_to @grounds_for_removability, notice: 'Grounds for removability was successfully updated.' }
        format.json { render :show, status: :ok, location: @grounds_for_removability }
      else
        format.html { render :edit }
        format.json { render json: @grounds_for_removability.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /grounds_for_removabilities/1
  # DELETE /grounds_for_removabilities/1.json
  def destroy
    @grounds_for_removability.destroy
    respond_to do |format|
      format.html { redirect_to grounds_for_removabilities_url, notice: 'Grounds for removability was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_grounds_for_removability
      @grounds_for_removability = GroundsForRemovability.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def grounds_for_removability_params
      params.require(:grounds_for_removability).permit(:name)
    end
end
