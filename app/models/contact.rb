class Contact
  include Mongoid::Document
  include Mongoid::Timestamps
  field :landline
  field :extension
  field :mobilenumber1
  field :mobilenumber2
  field :email
  field :alternative_email
  embedded_in :user
    embedded_in :regional
     embedded_in :branch
      embedded_in :warehouse
       embedded_in :transporter
        embedded_in :customer
         embedded_in :customerbranch
end
