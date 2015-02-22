class QueriesController < ApplicationController

  def advanced_search
      if params[:choice] == "clients"
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
