class RemovabilityGroundsController < ApplicationController
  before_action :set_removability_ground, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!
  respond_to :html

  def index
    @removability_grounds = RemovabilityGround.all
    respond_with(@removability_grounds)
  end

  def new
    @removability_ground = RemovabilityGround.new
    respond_with(@removability_ground)
  end

  def create
    if current_user && current_user.admin
      @removability_ground = RemovabilityGround.new(removability_ground_params)
      @removability_ground.name.upcase!
      if @removability_ground.save
        redirect_to removability_grounds_path, notice: "Removability Ground successfully added."
      else
        redirect_to removability_grounds_path, notice: "Removability Ground unable to be added."
      end
    else
      redirect_to removability_grounds_path, notice: "Only admin can create Removability Grounds"
    end
  end

  def destroy
    if current_user && current_user.admin
      @removability_ground.destroy
      redirect_to removability_grounds_path, notice: "Removability Ground successfully deleted."
    else
      redirect_to removability_grounds_path, notice: "Only admin can delete Removability Grounds"
    end
  end

  private
    def set_removability_ground
      @removability_ground = RemovabilityGround.find(params[:name])
    end

    def removability_ground_params
      params.require(:removability_ground).permit(:name)
    end
end
