class Customer
  include Mongoid::Document
  include Mongoid::Timestamps
  field :customer_name
  field :customer_code
  field :warehouse_id, type: Integer
  field :warehouse_code
  field :office_id, type: Integer
  field :isactive, type: Integer
  embeds_many :address
  embeds_many :contact
  accepts_nested_attributes_for :address
  accepts_nested_attributes_for :contact
end
