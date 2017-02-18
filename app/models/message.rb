class Message < ApplicationRecord
  validates_presence_of :talk, :body, :user

  belongs_to :talk
  belongs_to :user
end
