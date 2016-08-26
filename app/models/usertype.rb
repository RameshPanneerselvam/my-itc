class Usertype
  include Mongoid::Document
  include Mongoid::Timestamps
  field :type_name
  field :office_id, type: Integer
  field :description
  field :designation
  field :isactive, type: Integer
end
