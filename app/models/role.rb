class Role
  include Mongoid::Document
  include Mongoid::Timestamps
  field :role_name
  field :office_id, type: Integer
end
