class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_one_attached :image
  has_many :relationships, foreign_key: :following_id
  has_many :followings, through: :relationships, source: :follower

  has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: :follower_id
  has_many :followers, through: :reverse_of_relationships, source: :following

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :age
  belongs_to :sex
  belongs_to :voice
  belongs_to :platform
  belongs_to :favorite

  with_options presence: true do
    validates :image
    validates :nickname, length: { maximum: 10 }
    validates :profile
    with_options numericality: { other_than: 1, message: "can't be blank" } do
      validates :age_id
      validates :sex_id
      validates :voice_id
      validates :platform_id
      validates :favorite_id
    end
  end

  def is_followed_by?(user)
    reverse_of_relationships.find_by(following_id: user.id).present?
  end
end
