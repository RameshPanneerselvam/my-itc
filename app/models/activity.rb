class Activity
  include Mongoid::Document
  include Mongoid::Timestamps
  field :activity_name
  field :activity_description
  field :processmaster_id
  field :isactive
end
