class OfficeType
  include Mongoid::Document
  include Mongoid::Timestamps
  field :type_name
  field :description
  field :isactive, type: Integer
end
