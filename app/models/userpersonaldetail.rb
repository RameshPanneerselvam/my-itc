class Userpersonaldetail
  include Mongoid::Document
  include Mongoid::Timestamps
  field :dob
  field :gender
  field :user_id
  field :bloodgroup
  field :isactive
end
