class Branch
  include Mongoid::Document
  include Mongoid::Timestamps
  field :branch_name
  field :branch_code
  field :regional_id, type: Integer
  field :office_id, type: Integer
  field :isactive, type: Integer
  validates_presence_of :branch_name
  validates_presence_of :branch_code
  validates_presence_of :regional_id
  validates_presence_of :office_id
  embeds_many :address
  embeds_many :contact
  accepts_nested_attributes_for :address
  accepts_nested_attributes_for :contact
end
