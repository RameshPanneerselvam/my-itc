class ProcessLog
  include Mongoid::Document
  include Mongoid::Timestamps
  field :activity_id, type: Integer
  field :user_id, type: Integer
  field :process_specific_id, type: Integer
  field :status, type: Integer
  field :isactive, type: String
end 