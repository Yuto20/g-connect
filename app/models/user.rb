class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_many :plays, dependent: :destroy
  has_many :games, through: :plays
  has_one_attached :image

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :age
  belongs_to :sex
  belongs_to :voice

  with_options presence: true do
    validates :image
    validates :nickname, length: { maximum: 10 }
    validates :profile
    with_options numericality: { other_than: 1, message: "can't be blank" } do
      validates :age_id
      validates :sex_id
      validates :voice_id
    end
  end
  validates_associated :games


end
