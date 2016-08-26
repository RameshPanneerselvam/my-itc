class FieldProcess
  include Mongoid::Document
  include Mongoid::Timestamps
  field :field_type
  field :field_id
  field :specification
  field :classification_id
  field :tree_status
  field :subchild_flag
  field :isactive
end
