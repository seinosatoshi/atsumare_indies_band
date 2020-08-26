class Band < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :yells
  has_many :posts, dependent: :destroy
  has_many :subscribes, dependent: :destroy
  has_many :comments
  has_many :users, through: :comments
  has_many :receive_bands, through: :comments, class_name: 'Band', foreign_key: 'receiver_id'

  attachment :image

  # belongs_to :genre, optional: true
  belongs_to :prefecture, optional: true

  validates :name, presence: true
  validates :name_kana, presence: true, format: { with: /\A[ァ-ヶー－]+\z/ }

  def favorited_by?(user)
    subscribes.where(user_id: user.id).exists?
  end
end