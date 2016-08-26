class RemarkMaster
  include Mongoid::Document
  include Mongoid::Timestamps
  field :remark_name, type: String
  field :remark_description, type: String
  field :isactive, type: String
end
