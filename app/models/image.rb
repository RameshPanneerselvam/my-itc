class Image
  include Mongoid::Document
  include Mongoid::Timestamps
  field :image_path, type: String
  field :warehouse_id, type: String
  field :branch_id, type: String
  field :group, type: String
  field :isactive, type: String
  mount_uploader :image_path, ImagePathUploader
  has_many :fieldss ,:class_name=> "FieldMaster"
  accepts_nested_attributes_for :fieldss  , :allow_destroy => true 

end
