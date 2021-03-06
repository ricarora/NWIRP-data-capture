# Copyright (c) 2015 Richa Arora and Kate Fulton All Rights Reserved.

module QueriesHelper
  def model_fields # which fields to display and sort by
    if @clients
      [:first_name, :middle_name, :last_name, :nationality, :gender, :DRRU_CASE, :represented ]
    elsif @convictions
      [:client_name, :crime_name, :statute_of_conviction, :subsection, :DV_ON_ROC, :sentence, :sentence_type, :ij_name, :nta_charges, :ij_finding]
    end
  end

  def results_limit # max number of search results to display
    50
  end

  def display_query_sql(users)
    "SQL: #{users.to_sql}"
  end

  def display_results_header(count)
    if count > results_limit
      "Your first #{results_limit} results out of #{count} total"
    else
      "Your #{pluralize(count, 'result')}"
    end
  end

  def action
    action_name == 'advanced_search' ? :post : :get
  end

  def display_sort_column_headers(search)
    model_fields.each_with_object('') do |field, string|
      string << content_tag(:th, sort_link(search, field, {}, method: action))
    end
  end

  def display_search_results(objects)
    objects.limit(results_limit).each_with_object('') do |object, string|
      string << content_tag(:tr, display_search_results_row(object))
    end
  end

  def display_search_results_row(object)
    model_fields.each_with_object('') do |field, string|
      string << content_tag(:td, object.send(field))
    end
    .html_safe
  end
end
