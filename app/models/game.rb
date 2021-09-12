class Game < ApplicationRecord
  has_many :plays, dependent: :destroy
  has_many :users, through: :plays
  has_ancestry
  validates_associated :users

  validates :platform, presence: true
end
