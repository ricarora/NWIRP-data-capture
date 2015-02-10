module ApplicationHelper
  def setup_search_form(builder)
    fields = builder.grouping_fields builder.object.new_grouping,
      object_name: 'new_object_name', child_index: "new_grouping" do |f|
      render('grouping_fields', f: f)
    end
  end
end
