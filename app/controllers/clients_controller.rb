class ClientsController < ApplicationController
  before_action :set_client, only: [:show, :edit, :update, :destroy]

  def index
    @search = Client.search(params[:q])
    @search.build_condition if @search.conditions.empty?
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
    unless params[:client][:assessments_attributes]["0"]["date"] != ""
      @client.assessments.build
    end
    params[:client][:client_reliefs_attributes].each do |relief|
      unless relief[1]["relief_name"] != ""
        @client.client_reliefs.build
      end
    end
    #unless params[:client][:client_reliefs_attributes]["0"]["relief_name"] != ""
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
    if @client.update(client_params) && @client.ethnicity.update(params[:client][:ethnicity].reject(&:empty?))
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
    if params[:choice] == "client"
      @search = Client.search(params[:q])
      @search.build_condition if @search.conditions.empty?
      @clients  = params[:distinct].to_i.zero? ?
        @search.result :
        @search.result(distinct: true)
    else
      @search = Conviction.search(params[:q])
      @search.build_condition if @search.conditions.empty?
      @convictions  = params[:distinct].to_i.zero? ?
        @search.result :
        @search.result(distinct: true)
    end
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
