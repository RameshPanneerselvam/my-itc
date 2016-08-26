class Classification
  include Mongoid::Document
  include Mongoid::Timestamps
  field :classification_name
  field :classification_description
  field :isactive
end
