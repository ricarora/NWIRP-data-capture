# Copyright (c) 2015 Richa Arora and Kate Fulton All Rights Reserved.
class QueriesController < ApplicationController
  before_filter :authenticate_user!

  def advanced_search
    build_search
    @query = Query.new
  end

  def index
    @saved_queries = Query.all
  end

  def create
    @query = Query.new
    if params[:description] && params[:query_name]
      @query = Query.new(name: params[:query_name], description: params[:description].to_s, search_preference: params[:choice])
      if @query.save
        redirect_to saved_queries_path, notice: "The query is successfully saved."
      else
        build_search(@query)
        render :advanced_search, notice: "There was a problem, query was not saved. Try Again!"
      end
    end
  end

  def show
    @query = Query.find(params[:id])
    build_search(@query)
  end

  def destroy
    @query = Query.find(params[:id])
    if @query.destroy
      redirect_to :saved_queries, notice: "#{@query.name} query was successfully deleted."
    end
  end

  def build_search(query = nil)
    @query = query
    if @query
      params[:q] = JSON.parse @query.description.gsub('=>', ':')
      params[:choice] = @query.search_preference
    end
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
end
