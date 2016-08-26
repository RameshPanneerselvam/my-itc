class Folder
  include Mongoid::Document
  include Mongoid::Timestamps
  field :folder_name
  field :parent_folder_id
end
