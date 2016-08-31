class FieldProcess
  include Mongoid::Document
  include Mongoid::Timestamps
  field :field_type
  field :field_id, type: Integer
  field :specification
  field :classification_id, type: Integer
  field :tree_status
  field :subchild_flag
  field :isactive
end
