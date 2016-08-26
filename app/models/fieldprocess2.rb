class Fieldprocess2
  include Mongoid::Document
  field :name, type: String
  embedded_in :fieldprocess
end
