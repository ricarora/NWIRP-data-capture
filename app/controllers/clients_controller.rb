# Copyright (c) 2015 Richa Arora and Kate Fulton All Rights Reserved.
class ClientsController < ApplicationController
  before_action :set_client, only: [:show, :edit, :update, :destroy, :destroy_assessment]
  before_filter :authenticate_user!

  def index
    @clients = Client.all
    if params[:a_number_search]
      format_a_number(params[:a_number_search])
      @client = Client.find_client_by_a_number(params[:a_number_search])
      if @client
        @clients = [@client]
        render :index
      else
        flash.now[:notice] = "There is currently no client with A#: #{params[:a_number_search]}"
        params[:a_number]
        render '/clients/find'
      end
    elsif params[:last_name_search] || params[:first_name_search]
      @clients = Client.find_client_by_name(params[:last_name_search], params[:first_name_search])
      if !@clients.empty?
        render :index
      else
        flash.now[:notice] = "There is currently no client with that name."
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
    remove_blank_assessments_and_mark_for_destruction
    remove_blank_reliefs_and_mark_for_destruction
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
    remove_blank_assessments_and_mark_for_destruction
    remove_blank_reliefs_and_mark_for_destruction
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
    if current_user && current_user.admin
      @client.convictions.each {|conviction| conviction.destroy}
      @client.destroy
      redirect_to clients_url, notice: 'Client was successfully destroyed.'
    end
  end

  private

    def set_client
      @client = Client.find(params[:id])
    end

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

    def remove_blank_reliefs_and_mark_for_destruction
      params[:client][:client_reliefs_attributes].each do |index, name|  #remove blank assessment dates from params
        if name.has_key?("relief_name")
          if name["relief_name"].blank?
            params[:client][:client_reliefs_attributes].delete(index)
          end
        end
        if name.has_key?("_destroy")
          @client.client_reliefs.find(name["id"].to_i).mark_for_destruction
        end
      end
    end

    def remove_blank_assessments_and_mark_for_destruction
      params[:client][:assessments_attributes].each do |index, date|  #remove blank assessment dates from params
        if date.has_key?("date")
          if date["date"].blank?
            params[:client][:assessments_attributes].delete(index)
          end
        end
        if date.has_key?('_destroy')
          @client.assessments.find(date["id"].to_i).mark_for_destruction
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
                                     :middle_name,
                                     :first_name,
                                     :nationality,
                                     :ethnicity,
                                     :gender,
                                     :relief_sought,
                                     :represented,
                                     :drru_case,
                                     :a_number,
                                     :assessments_attributes => [:id, :date, :_destroy],
                                     :client_reliefs_attributes => [:id, :relief_name, :_destroy])
    end
end
