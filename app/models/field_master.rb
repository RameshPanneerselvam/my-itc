class FieldMaster
  include Mongoid::Document
  include Mongoid::Timestamps
  field :field_name
  field :field_type
  field :isactive
 # belongs_to :classification
end
