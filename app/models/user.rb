class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :image

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :age
  belongs_to :sex
  belongs_to :voice

  with_options presence: true do
    validates :nickname, length: { maximum: 10 }
    validates :voice_id
    validates :profile
  end

  with_options numericality: { other_than: 1, message: "can't be blank" } do
      validates :voice_id
  end

end
