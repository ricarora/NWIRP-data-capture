class ConvictionsController < ApplicationController
  before_action :set_conviction, only: [:show, :edit, :update, :destroy]

  # GET /convictions
  # GET /convictions.json
  def index
    @convictions = Conviction.all
  end

  # GET /convictions/1
  # GET /convictions/1.json
  def show
  end

  # GET /convictions/new
  def new
    @conviction = Conviction.new
    # @conviction.id = @conviction.set_number
    @conviction.conviction_grounds = RemovabilityGround.all.map {|rg| @conviction.conviction_grounds.build(gor_name: rg.name, conviction_id: @conviction.id)}
  end

  # GET /convictions/1/edit
  def edit
  end

  # POST /convictions
  # POST /convictions.json
  def create
    @conviction = Conviction.new
    @conviction.client_id = params[:client_id]
    params[:conviction][:conviction_grounds_attributes].map { |key, cg_hash| @conviction.conviction_grounds(gor_name: cg_hash[:gor_name], status: cg_hash[:status]) }
    @conviction.attributes = conviction_params
    respond_to do |format|
      if @conviction.save
        format.html { redirect_to client_path(@conviction.client_id), notice: 'Conviction was successfully created.' }
        format.json { render :show, status: :created, location: @conviction }
      else
        format.html { render :new }
        format.json { render json: @conviction.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /convictions/1
  # PATCH/PUT /convictions/1.json
  def update
    respond_to do |format|
      if @conviction.update(conviction_params)
        format.html { redirect_to @conviction, notice: 'Conviction was successfully updated.' }
        format.json { render :show, status: :ok, location: @conviction }
      else
        format.html { render :edit }
        format.json { render json: @conviction.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /convictions/1
  # DELETE /convictions/1.json
  def destroy
    @conviction.destroy
    respond_to do |format|
      format.html { redirect_to convictions_url, notice: 'Conviction was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_conviction
      @conviction = Conviction.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def conviction_params
      params.require(:conviction).permit(:crime_name, :rcw, :subsection, :sentence, :ij_name, :nta_charges, :ij_decision_date, :ij_finding, :notes, :conviction_grounds_attributes => [:gor_name, :status])
    end
end
