class Regional
  include Mongoid::Document
  include Mongoid::Timestamps
  field :regional_name
  field :regional_code
  field :office_id, type: Integer
  validates_presence_of :regional_name
  validates_presence_of :regional_code
  validates_presence_of :office_id
  embeds_many :address
  embeds_many :contact
  accepts_nested_attributes_for :address
  accepts_nested_attributes_for :contact
end
