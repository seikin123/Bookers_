class User < ApplicationRecord
  validates :name, presence: true, uniqueness:true, length: {in: 2..20}
  validates :introduction,length: { maximum: 50}


  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :validatable
  attachment :profile_image
  # コメント機能の記述
  has_many :book_comments, dependent: :destroy
  # いいね機能の記述
  has_many :favorites, dependent: :destroy

  def already_favorited?(book)
    self.favorites.exists?(book_id: book.id)
  end
  # フォロー機能の記述
  has_many :relationships
  has_many :followings, through: :relationships, source: :follow
  has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: 'follow_id'
  has_many :followers, through: :reverse_of_relationships, source: :user

  def follow(other_user)
    unless self == other_user
      self.relationships.find_or_create_by(follow_id: other_user.id)
    end
  end

  def unfollow(other_user)
    relationship = self.relationships.find_by(follow_id: other_user.id)
    relationship.destroy if relationship
  end

  def following?(other_user)
    self.followings.include?(other_user)
  end

  # 検索機能
  def self.search(search)
    return User.all unless search
    User.where(['name LIKE ?', "%#{search}%"])
  end

end
