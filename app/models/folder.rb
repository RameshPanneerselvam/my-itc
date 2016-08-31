class Folder
  include Mongoid::Document
  include Mongoid::Timestamps
  field :folder_name
  field :warehouse_id, type:Integer
  field :branch_id, type: Integer
  validates_presence_of :folder_name
end
