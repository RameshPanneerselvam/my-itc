class Pagemaster
  include Mongoid::Document
  include Mongoid::Timestamps
  field :page_name
  field :page_url
  field :icons
  field :order
  field :parent_id, type: Integer
  field :office_id, type: Integer
end
