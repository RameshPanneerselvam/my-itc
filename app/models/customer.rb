class Customer
  include Mongoid::Document
  include Mongoid::Timestamps
  field :customer_name
  field :customer_code
  field :warehouse_id, type: Integer
  field :warehouse_code
  field :office_id, type: Integer
  field :isactive, type: Integer
  validates_presence_of :customer_name
  validates_presence_of :customer_code
  validates_presence_of :warehouse_id
  validates_presence_of :warehouse_code
  validates_presence_of :office_id
  embeds_many :address
  embeds_many :contact
  accepts_nested_attributes_for :address
  accepts_nested_attributes_for :contact
end
