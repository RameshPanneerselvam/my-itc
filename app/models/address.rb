class Address
  include Mongoid::Document
  include Mongoid::Timestamps
  field :address1
  field :address2
  field :city
  field :state
  field :country
  validates_presence_of :address1
  validates_presence_of :city
  validates_presence_of :state
  validates_presence_of :country
   embedded_in :user
    embedded_in :regional
     embedded_in :branch
      embedded_in :warehouse
       embedded_in :transporter
        embedded_in :customer
         embedded_in :customerbranch
end
