class Talk < ApplicationRecord
  validates_presence_of :user, :property

  belongs_to  :user
  belongs_to  :property
  has_many    :messages
  belongs_to  :reservation
end
