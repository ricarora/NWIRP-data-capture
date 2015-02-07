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
    @conviction_grounds = RemovabilityGround.all.collect do |rg|
      ConvictionGround.new(gor_name: rg.name, conviction_id: @conviction_id, status: "")
    end
  end

  def edit
  end

  def create
    @conviction_ground = ConvictionGround.new(conviction_ground_params)
    if @conviction_ground.save
      redirect_to @conviction_ground, notice: 'Conviction ground was successfully created.'
    else
      render :new
    end
  end

  def update
    if @conviction_ground.update(conviction_ground_params)
      redirect_to @conviction_ground, notice: 'Conviction ground was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @conviction_ground.destroy
    redirect_to conviction_grounds_url, notice: 'Conviction ground was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_conviction_ground
      @conviction_ground = ConvictionGround.find(params[:id])
    end

    def conviction_ground_params
      params.require(:conviction_ground).permit(:gor_name, :conviction_id, :status)
    end
end
