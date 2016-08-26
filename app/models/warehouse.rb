class Warehouse
  include Mongoid::Document
  include Mongoid::Timestamps
  field :warehouse_name
  field :warehouse_code
  field :branch_id, type: Integer
  field :branch_code
  field :office_id, type: Integer
  embeds_many :address
  embeds_many :contact
  accepts_nested_attributes_for :address
  accepts_nested_attributes_for :contact
end
