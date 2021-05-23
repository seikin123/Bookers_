class Book < ApplicationRecord
  validates :title, presence: true
  validates :body, length: { in: 1..200 }
  belongs_to :user
  has_many :favorites, dependent: :destroy
  # コメント機能の記述
  has_many :book_comments, dependent: :destroy

  def self.search(search)
    return Book.all unless search
    Book.where(['title LIKE ?', "%#{search}%"])
  end
  
  
end
