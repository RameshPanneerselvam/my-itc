class PageSetting
  include Mongoid::Document
  include Mongoid::Timestamps
  field :user_id, type: Integer
  field :page_id
end
