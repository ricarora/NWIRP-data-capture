class ClientsController < ApplicationController
  before_action :set_client, only: [:show, :edit, :update, :destroy]

  def index
    @search = Client.search_with_scopes(params[:q])
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
      build_relief_fields
      build_assessment_fields
    end
  end

  def edit
    client = Client.find(params[:id])
    build_relief_fields
    build_assessment_fields
  end

  def create
    @client = Client.new
    format_a_number
    @client.attributes = client_params
    remove_blank_assessments
    remove_blank_reliefs
    @client.ethnicity = params[:client][:ethnicity].reject(&:empty?)
    if @client.save
      redirect_to client_path(@client.id), notice: 'Client was successfully created.'
    else
      build_relief_fields
      build_assessment_fields
      render :new
    end
  end

  def build_assessment_fields
    (10 - @client.assessments.length).times do
      @client.assessments.build
    end
  end

  def build_relief_fields
    (10 - @client.client_reliefs.length).times do
      @client.client_reliefs.build
    end
  end

  def update
    remove_blank_assessments
    remove_blank_reliefs
    #check_assessments
    #check_client_reliefs
    @client.ethnicity = params[:client][:ethnicity].reject(&:empty?)
    if @client.update(client_params)
      redirect_to @client, notice: 'Client was successfully updated.'
    else
      render :edit
      build_relief_fields
      build_assessment_fields
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

    def set_client
      @client = Client.find(params[:id])
    end

    # def check_client_reliefs
    #   @client.client_reliefs.each do |relief|
    #     params[:client][:client_reliefs_attributes].each do |index, name|
    #       name.each do |k,v|
    #         if relief.relief_name == v
    #           return true
    #         else
    #           relief.destroy
    #         end
    #       end
    #     end
    #   end
    # end

    def check_assessments
      @client.assessments.each do |assessment|
        params[:client][:assessments_attributes].each do |index, date|
          date.each do |k,v|
            if assessment.date == v
              return true
            end
            assessment.destroy
          end
        end
      end
    end

    def remove_blank_reliefs
      params[:client][:client_reliefs_attributes].each do |index, name|  #remove blank assessment dates from params
        name.each do |k, v|
          if v.blank?
            params[:client][:client_reliefs_attributes].delete(index)
          end
        end
      end
    end

    def remove_blank_assessments
      params[:client][:assessments_attributes].each do |index, date|  #remove blank assessment dates from params
        date.each do |k, v|
          if v.blank?
            params[:client][:assessments_attributes].delete(index)
          end
        end
      end
    end

    def format_a_number
      if params[:client][:a_number].length == 9
        params[:client][:a_number].insert(3, "-").insert(7, "-")
      end
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
