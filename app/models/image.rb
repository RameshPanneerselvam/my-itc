class Image
  include Mongoid::Document
  include Mongoid::Timestamps
  field :image_path, type: String
  field :warehouse_id, type: Integer
  field :branch_id, type: Integer
  field :group, type: String
  field :isactive, type: String
  mount_uploader :image_path, ImagePathUploader

end
