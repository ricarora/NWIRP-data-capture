class ClientsController < ApplicationController
  before_action :set_client, only: [:show, :edit, :update, :destroy]

  def index
    # @search = Client.search(params[:q])
    # @clients = @search.result
    # @search.build_condition if @search.conditions.empty?
    @search = Client.search(params[:q])
    @client  = params[:distinct].to_i.zero? ?
      @search.result :
      @search.result(distinct: true)
  end

  def show
  end

  def new
    @client_form = ClientBuildForm.new
  end

  def edit
  end

  def create
    @client_form = ClientBuildForm.new
    if @client_form.submit(params[:client_build_form]) && @client_form.all_valid? && @client_form.save
      redirect_to client_path(@client_form.client)
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
    @convictions  = params[:distinct].to_i.zero? ?
      @search.result :
      @search.result(distinct: true)

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_client
      @client = Client.find(params[:id])
    end
end
