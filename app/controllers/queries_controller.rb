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
        if params[:query_save] && params[:query_name]
          save_query(params[:query_name], @search)
        end
        @search.build_condition if @search.conditions.empty?
        @convictions  = params[:distinct].to_i.zero? ?
          @search.result :
          @search.result(distinct: true)
      end
  end

  def save_query(name, search)
    # checks if name & value both are present
    if params[:q]["c"]["0"]["a"]["0"]["name"].length > 0 && params[:q]["c"]["0"]["v"]["0"]["value"].length > 0
      @search.conditions.present?
      q = Query.new(name: name, description: search)
      q.save
    end
  end
end
