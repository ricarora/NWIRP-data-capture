class ClientsController < ApplicationController
  before_action :set_client, only: [:show, :edit, :update, :destroy, :destroy_assessment]

  def index
    @clients = Client.all
    if params[:a_number_search]
      format_a_number(params[:a_number_search])
      @client = Client.find_client_by_a_number(params[:a_number_search])
      if @client
        redirect_to client_path(@client.id)
      else
        flash.now[:notice] = "There is currently no client with A#: #{params[:a_number_search]}"
        params[:a_number]
        render '/clients/find'
      end
    else
      render :index
    end
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
    format_a_number(params[:client][:a_number])
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

  def destroy_assessment
    @assessment = Assessment.find(params[:assessment_id])
    if @assessment.client_id == params[:id].to_i
      @assessment.destroy
    end
    redirect_to edit_client_path(params[:id])
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

    def format_a_number(a_number)
      if a_number.length == 9
        a_number.insert(3, "-").insert(7, "-")
      end
      if a_number.length == 11
        a_number[3] = "-"
        a_number[7] = "-"
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
