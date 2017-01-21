class Property < ApplicationRecord
  # Os possiveis status de uma Propriedades
  enum status: [ :active, :pending, :inactive, :blocked ]
  # Os tipos de acomodação: casa inteira, quarto inteiro e quarto compartilhado
  enum accommodation_type: [ :whole_house, :whole_bedroom, :shared_bedroom ]

  belongs_to :user
  belongs_to :address
  belongs_to :facility
  has_many :wishlists
  has_many :photos
end
