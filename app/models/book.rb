class Book < ApplicationRecord
	belongs_to :user
	#バリデーションは該当するモデルに設定する。エラーにする条件を設定できる。
	has_many :favorites, dependent: :destroy
	def favorited_by?(user)
		favorites.where(user_id: user.id).exists?
	end
	has_many :book_comments, dependent: :destroy
	#presence trueは空欄の場合を意味する。
	validates :title, presence: true
	validates :body, presence: true, length: {maximum: 200}
  # def self.search(method, word)
  #   @books = if method == 'forward_match'
  #              Book.where('text LIKE?', "#{word}%")
  #            elsif method == 'backward_match'
  #              Book.where('text LIKE?', "%#{word}")
  #            elsif method == 'perfect_match'
  #              Book.where(word.to_s)
  #            elsif method == 'partial_match'
  #              Book.where('text LIKE?', "%#{word}%")
  #            else
  #              Book.all
  #            end
  #   end
end
