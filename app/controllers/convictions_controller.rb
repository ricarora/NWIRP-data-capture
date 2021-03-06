# Copyright (c) 2015 Richa Arora and Kate Fulton All Rights Reserved.

class ConvictionsController < ApplicationController
  before_action :set_conviction, only: [:edit, :update, :destroy]
  before_filter :authenticate_user!

  def index
    @convictions = Conviction.all
  end

  def show
    @client = Client.find(params[:client_id])
  end

  def new
    @conviction = Conviction.new
    @client = Client.find(params[:client_id])
    @conviction.conviction_grounds = RemovabilityGround.all.map do |rg|
      @conviction.conviction_grounds.build(gor_name: rg.name, conviction_id: @conviction.id)
    end
  end

  def edit
    @client = Client.find(params[:client_id])
    @conviction = Conviction.find(params[:id])
  end

  def create
    @conviction = Conviction.new
    @client = Client.find(params[:client_id])
    @conviction.client_id = params[:client_id]
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

  def convert_to_days(sentence, sentence_unit)
    case sentence_unit
      when "Sentence Unknown"
        sentence == ""
      when "Year(s)"
        sentence * 365
      when "Month(s)"
        sentence * 30
      else
        sentence
    end
  end

  def update
    @client = Client.find(params[:client_id])
    if @conviction.update(conviction_params)
      redirect_to client_path(@conviction.client_id), notice: 'Conviction was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    if current_user && current_user.admin
      @conviction.destroy
      redirect_to client_path(params[:client_id]), notice: 'Conviction was successfully destroyed.'
    end
  end

  private

    def set_conviction
      @conviction = Conviction.find(params[:id])
    end

    def conviction_params
      params.require(:conviction).permit(:crime_name,
                                        :statute_of_conviction,
                                        :dv_on_roc,
                                        :subsection,
                                        :sentence,
                                        :sentence_type,
                                        :state_committed,
                                        :ij_name,
                                        :nta_charges,
                                        :ij_decision_date,
                                        :ij_finding,
                                        :notes, 
                                        :conviction_grounds_attributes => [:id, :gor_name, :status])
    end
end
