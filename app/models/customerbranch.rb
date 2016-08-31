class Customerbranch
  include Mongoid::Document
  include Mongoid::Timestamps
  field :customer_name
  field :customerbranch_code
  field :customer_id, type: Integer
  field :customer_code
  field :office_id, type: Integer
  field :isactive, type: Integer
  validates_presence_of :customer_name
  validates_presence_of :customerbranch_code
  validates_presence_of :customer_id
  validates_presence_of :office_id
  validates_presence_of :customer_code
  embeds_many :address
  embeds_many :contact
  accepts_nested_attributes_for :address
  accepts_nested_attributes_for :contact
end
