class RemovabilityGroundsController < ApplicationController
  before_action :set_removability_ground, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @removability_grounds = RemovabilityGround.all
    respond_with(@removability_grounds)
  end

  def show
    respond_with(@removability_ground)
  end

  def new
    @removability_ground = RemovabilityGround.new
    respond_with(@removability_ground)
  end

  def edit
  end

  def create
    @removability_ground = RemovabilityGround.new(removability_ground_params)
    @removability_ground.save
    respond_with(@removability_ground)
  end

  def update
    @removability_ground.update(removability_ground_params)
    respond_with(@removability_ground)
  end

  def destroy
    @removability_ground.destroy
    respond_with(@removability_ground)
  end

  private
    def set_removability_ground
      @removability_ground = RemovabilityGround.find(params[:id])
    end

    def removability_ground_params
      params.require(:removability_ground).permit(:name)
    end
end
