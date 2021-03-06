class Band < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :yells, dependent: :destroy
  has_many :yells_user, through: :yells, source: :user
  has_many :subscribes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :users, through: :comments
  has_many :receive_bands, through: :comments, class_name: 'Band', foreign_key: 'receiver_id', inverse_of: :band
  has_many :audios, dependent: :destroy

  attachment :image

  validates :name, presence: true

  acts_as_paranoid

  def favorited_by?(user)
    subscribes.where(user_id: user.id).exists?
  end

  def yelled_at_by?(user)
    s.where(user_id: user.id).exists?
  end

  def self.all_ranks
    Band.find(Yell.group(:band_id).order('count(band_id) desc').limit(5).pluck(:band_id))
  end
  # selfが多い場合は以下の記述の方が効率的
  # class << self
  #   def all_ranks
  #     Band.find(Yell.group(:band_id).order('count(band_id) desc').limit(3).pluck(:band_id))
  #   end
  # end
end
