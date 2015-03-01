class ReliefSoughtsController < ApplicationController
  before_action :set_relief_sought, only: [:update, :destroy]
  before_filter :authenticate_user!
  respond_to :html

  def index
    @relief_soughts = ReliefSought.all
    respond_with(@relief_soughts)
  end

  def new
    @relief_sought = ReliefSought.new
    respond_with(@relief_sought)
  end

  def create
    if current_user && current_user.admin
      @relief_sought = ReliefSought.new(relief_sought_params)
      @relief_sought.name.upcase!
      if @relief_sought.save
        redirect_to relief_soughts_path, notice: "Relief Sought successfully added."
      else
        redirect_to relief_soughts_path, notice: "Relief Sought unable to be added."
      end
    else
      redirect_to relief_soughts_path, notice: "Only admin can create Relief Soughts."
    end
  end

  def destroy
    if current_user && current_user.admin
      @relief_sought.destroy
      redirect_to relief_soughts_path, notice: "Relief Sought successfully deleted."
    else
      redirect_to relief_soughts_path, notice: "Only admin can delete Relief Soughts."
    end
  end

  private
    def set_relief_sought
      @relief_sought = ReliefSought.find(params[:name])
    end

    def relief_sought_params
      params.require(:relief_sought).permit(:name)
    end
end
