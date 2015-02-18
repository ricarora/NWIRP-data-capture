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
      build_relief_fields
    end
  end

  def edit
    client = Client.find(params[:id])
    # 2.times do
    #   @client.client_reliefs.build
    # end
  end

  def create
    @client = Client.new
    # puts "client_reliefs is #{@client.client_reliefs.inspect}"
    if params[:client][:assessments_attributes]["0"]["date"] == ""
      @client.assessments.build
    end
    
    @client.attributes = client_params
    build_relief_fields
    @client.ethnicity = params[:client][:ethnicity].reject(&:empty?)
    if @client.save
      redirect_to client_path(@client.id), notice: 'Client was successfully created.'
    else
      render :new
    end
  end

  def build_relief_fields
    (5 - @client.client_reliefs.length).times do
      @client.client_reliefs.build
    end
  end

  def update
    @client.ethnicity = params[:client][:ethnicity].reject(&:empty?)
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
