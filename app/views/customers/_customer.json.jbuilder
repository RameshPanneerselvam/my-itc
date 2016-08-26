json.extract! customer, :id, :customer_name, :warehouse_id, :created_at, :updated_at
json.url customer_url(customer, format: :json)