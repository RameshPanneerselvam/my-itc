class Classification
  include Mongoid::Document
  include Mongoid::Timestamps
  field :classification_name
  field :classification_description
  validates_presence_of :classification_name
  validates_presence_of :classification_description
  field :isactive
end
