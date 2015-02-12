class ClientsController < ApplicationController
  before_action :set_client, only: [:show, :edit, :update, :destroy]

  def index
    @search = Client.search(params[:q])
    @clients  = params[:distinct].to_i.zero? ?
      @search.result :
      @search.result(distinct: true)
  end

  def show
  end

  def new
    @client = Client.new
    @client.assessments.build(client_id: @client.id)
    @client.client_reliefs.build(client_id: @client.id)
  end

  def edit
    client = Client.find(params[:id])
    @client_form = ClientBuildForm.new(client)
  end

  def create
    @client = Client.new
    raise
    params[:conviction][:conviction_grounds_attributes].map do |key, cg_hash|
      @conviction.conviction_grounds(gor_name: cg_hash[:gor_name], status: cg_hash[:status])
    end
    @conviction.attributes = conviction_params
    @conviction.sentence = convert_to_days(conviction_params[:sentence].to_i, params[:conviction][:sentence_unit])
    if @conviction.save
      redirect_to client_path(@conviction.client_id), notice: 'Conviction was successfully created.'
    else
      render :new
    end
  end

  def update
    if @client.update(client_params)
      redirect_to @client, notice: 'Client was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @client.destroy
    redirect_to clients_url, notice: 'Client was successfully destroyed.'
  end

  def search
    # using search from ransack gem. This might change depending on the search
    index
    render :index
  end

  def advanced_search
    @search = Client.search(params[:q])
    @search.build_grouping unless @search.groupings.any?
    @clients  = params[:distinct].to_i.zero? ?
      @search.result :
      @search.result(distinct: true)

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_client
      @client = Client.find(params[:id])
    end

    def client_params
      params.require(:client).permit(:last_name, :first_name, :nationality, :ethnicity, :gender, :relief_sought, :represented, :drru_case, :a_number, :assessments_attributes => [:id, :date], :client_reliefs_attributes => [:id, :relief_name])
    end
end
