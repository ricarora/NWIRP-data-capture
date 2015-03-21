# Copyright (c) 2015 Richa Arora and Kate Fulton All Rights Reserved.
class QueriesController < ApplicationController

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
        if @search.conditions.present? && params[:query_save] && params[:query_name]
          q = Query.new(name: params[:query_name], description: params[:q].to_s, search_preference: "Conviction")
          if q.save
            flash.now[:notice] = "The query is successfully saved."
          else
            flash.now[:notice] = "There was a problem, query was not saved. Try Again!"
          end
        end
      end
  end

  def save_query(name, search, preference)
    # checks if name & value both are present
    # JSON.parse some.gsub('=>', ':')
  end
end
