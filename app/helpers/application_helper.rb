module ApplicationHelper
  def setup_search_form(builder)
    fields = builder.grouping_fields builder.object.new_grouping,
      object_name: 'new_object_name', child_index: "new_grouping" do |f|
      render('grouping_fields', f: f)
    end
  end

  def button_to_remove_fields(name, f)
    content_tag :button, name, class: 'remove_fields'
  end

  def button_to_add_fields(name, f, type)
    new_object = f.object.send "build_#{type}"
    fields = f.send("#{type}_fields", new_object, child_index: "new_#{type}") do |builder|
      render(type.to_s + "_fields", f: builder)
    end
    content_tag :button, name, :class => 'add_fields', 'data-field-type' => type, 'data-content' => "#{fields}"
  end
end
