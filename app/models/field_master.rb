class FieldMaster
  include Mongoid::Document
  include Mongoid::Timestamps
  field :field_name
  field :isactive
  validates_presence_of :field_name
end
