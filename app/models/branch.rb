class Branch
  include Mongoid::Document
  include Mongoid::Timestamps
  field :branch_name
  field :branch_code
  field :regional_id, type: Integer
  field :office_id, type: Integer
  field :isactive, type: Integer
  embeds_many :address
  embeds_many :contact
  accepts_nested_attributes_for :address
  accepts_nested_attributes_for :contact
end
