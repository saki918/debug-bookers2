class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable,:validatable

  has_many :books
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  attachment :profile_image, destroy: false

  has_many :relationships
  # through: :relationships は「中間テーブルはrelationshipsだよ」って設定してあげてるだけです。
  # source: :followとありますが、これは
  # 「relationshipsテーブルのfollow_idを参考にして、followingsモデルにアクセスしてね」って事
  # user.followings と打つだけで、user が中間テーブル relationships を取得し、
  # その1つ1つの relationship のfollow_idから、「フォローしている User 達」を取得
  has_many :followings, through: :relationships, source: :follow
  # has_many :reverse_of_relationshipsはhas_many :relaitonshipsの「逆方向」
  # class_name: 'Relationship'で「relationsipモデルの事だよ〜」と設定
  # relaitonshipsテーブルにアクセスする時、follow_idを入口として来てね！」
  # foregin_key = 入口 source = 出口
  has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: 'follow_id'
  # through: :reverses_of_relationshipで「中間テーブルはreverses_of_relationshipにしてね」と設定し、
  # source: :userで「出口はuser_idね！それでuserテーブルから自分をフォローしているuserをとってきてね！」と設定
  has_many :followers, through: :reverse_of_relationships, source: :user

  
  def follow(other_user)
    # unless self == other_user によって、フォローしようとしている other_user が自分自身ではないかを検証
    unless self == other_user
      self.relationships.find_or_create_by(follow_id: other_user.id)
    end
  end

  def unfollow(other_user)
    # フォローがあればアンフォローしています。また、relationship.destroy 
    # if relationshipは、 relationship が存在すれば destroy
    relationship = self.relationships.find_by(follow_id: other_user.id)
    relationship.destroy if relationship
  end

  def following?(other_user)
    # def following? では、self.followings によりフォローしている User 達を取得し、
    # include?(other_user) によって other_user が含まれていないかを確認
    # 含まれている場合には、true を返し、含まれていない場合には、false を返す
    self.followings.include?(other_user)
  end

  #バリデーションは該当するモデルに設定する。エラーにする条件を設定できる。
  validates :name, length: {minimum: 2,maximum: 20}
  validates :introduction, length: { maximum: 50 }
  def current_user?(user)
    user == current_user
  end
end
