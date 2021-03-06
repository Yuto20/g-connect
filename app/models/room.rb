class Room < ApplicationRecord
  has_many :users, through: :entries
  has_many :entries, dependent: :destroy
  has_many :direct_messages, dependent: :destroy
end
