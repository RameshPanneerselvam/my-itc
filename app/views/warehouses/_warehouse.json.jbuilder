json.extract! warehouse, :id, :warehouse_name, :branch_id, :created_at, :updated_at
json.url warehouse_url(warehouse, format: :json)