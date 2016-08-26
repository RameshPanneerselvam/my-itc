class Fieldprocess
  include Mongoid::Document
  field :name, type: String
  embeds_many :fieldprocess1
  accepts_nested_attributes_for :fieldprocess1
end
