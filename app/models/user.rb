class User
  include Mongoid::Document
   #include Mongoid::Userstamp::User
  include Mongoid::Timestamps
  field :first_name
  field :last_name
  field :user_name
  field :password
  field :usertype, type: Integer
  field :role, type: Integer
  field :office_id, type: Integer
  field :parent_id, type: Integer
  field :parent_code
  embeds_many :address
  embeds_many :contact
  accepts_nested_attributes_for :address
  accepts_nested_attributes_for :contact


end
