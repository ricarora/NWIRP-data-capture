class ConvictionGroundsController < ApplicationController
  before_action :set_conviction_ground, only: [:show, :edit, :update, :destroy]

  def index
    @conviction_grounds = ConvictionGround.all
  end

  def show
  end

  def new
    @conviction_ground = ConvictionGround.new
    @client_id = params[:client_id]
    @conviction_id = params[:conviction_id]
    @conviction_grounds = RemovabilityGround.all.collect {|rg| ConvictionGround.new(gor_name: rg.name, conviction_id: @conviction_id, status: "")}
  end

  def edit
  end

  def create
    @conviction_ground = ConvictionGround.new(conviction_ground_params)
    @conviction_grounds = RemovabilityGround.all.collect {|rg| ConvictionGround.new(gor_name: rg.name, conviction_id: @conviction_id, status: "")}
    respond_to do |format|
      if @conviction_ground.save
        format.html { redirect_to @conviction_ground, notice: 'Conviction ground was successfully created.' }
        format.json { render :show, status: :created, location: @conviction_ground }
      else
        format.html { render :new }
        format.json { render json: @conviction_ground.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @conviction_ground.update(conviction_ground_params)
        format.html { redirect_to @conviction_ground, notice: 'Conviction ground was successfully updated.' }
        format.json { render :show, status: :ok, location: @conviction_ground }
      else
        format.html { render :edit }
        format.json { render json: @conviction_ground.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @conviction_ground.destroy
    respond_to do |format|
      format.html { redirect_to conviction_grounds_url, notice: 'Conviction ground was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_conviction_ground
      @conviction_ground = ConvictionGround.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def conviction_ground_params
      params.require(:conviction_ground).permit(:gor_name, :conviction_id, :status)
    end
end
