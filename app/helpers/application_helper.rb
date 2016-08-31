module ApplicationHelper

    def flash_class(level)
        
        case level.to_sym
    
            when :notice then "alert alert-info"
    
            when :success then "alert alert-success"

            when :warning then "alert alert-warning"

            when :danger then "alert alert-danger"
    
            when :error then "alert alert-error"
    
            when :alert then "alert alert-error"
    
        end
  end

  def link_to_add_fields(field_name, f, association)
  
    new_object = f.object.send(association).klass.new 
  
    id = new_object.object_id
  
    fields = f.fields_for(association, new_object, child_index: id) do |builder|
  
        render(association.to_s.singularize + "_fields", f: builder)
    end
   
    link_to(field_name, '#',class: "add_fields", data: {id: id,fields: fields.gsub("\n",'')})
  
  end

end
