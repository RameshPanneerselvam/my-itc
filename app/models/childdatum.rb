class Childdatum
  include Mongoid::Document
  include Mongoid::Timestamps
  field :field_name
  field :field_value
  field :datacapture_id, type: Integer
  field :parent_id, type: Integer
  field :isactive
end
