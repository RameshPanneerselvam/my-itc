json.extract! usertype, :id, :type_name, :office_id, :description, :isactive, :created_at, :updated_at
json.url usertype_url(usertype, format: :json)