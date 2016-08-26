class Transporter
  include Mongoid::Document
  include Mongoid::Timestamps
  field :transporter_name
  field :transporter_code
  field :warehouse_id, type: Integer
  field :warehouse_code
  field :office_id, type: Integer
  embeds_many :address
  embeds_many :contact
  accepts_nested_attributes_for :address
  accepts_nested_attributes_for :contact
end
