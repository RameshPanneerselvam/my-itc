class ProcessMaster
  include Mongoid::Document
  include Mongoid::Timestamps
  field :process_name, type: String
  field :process_description, type: String
  field :isactive, type: String
end
