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
    unless @client
      @client = Client.new
      @client.assessments.build
      @client.client_reliefs.build
    end
  end

  def edit
    client = Client.find(params[:id])
  end

  def create
    @client = Client.new
    @client.assessments.build
    @client.client_reliefs.build
    # p @client
    # params[:client][:client_reliefs_attributes].map do |key, cr_hash|
    #   if !cr_hash[:relief_name].empty?
    #     @client.client_reliefs(relief_name: cr_hash[:relief_name])
    #   end
    # end
    # params[:client][:assessments_attributes].map do |key, ass_hash|
    #   @client.assessments(date: ass_hash[:date])
    # end
    @client.attributes = client_params
    @client.ethnicity = params[:client][:ethnicity].reject(&:empty?)
    if @client.save
      redirect_to client_path(@client.id), notice: 'Client was successfully created.'
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
      params.require(:client).permit(:last_name,
                                     :first_name,
                                     :nationality,
                                     :ethnicity,
                                     :gender,
                                     :relief_sought,
                                     :represented,
                                     :drru_case,
                                     :a_number,
                                     :assessments_attributes => [:id, :date],
                                     :client_reliefs_attributes => [:id, :relief_name])
    end
end
