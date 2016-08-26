class Childdatum
  include Mongoid::Document
  include Mongoid::Timestamps
  field :field_name
  field :field_value
  field :datacapture_id
  field :parent_id
  field :isactive
end
