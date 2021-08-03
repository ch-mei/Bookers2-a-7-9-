class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :followed_users, through: :relationships, source: :followed
  has_many :reverse_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :followers, through: :reverse_relationships, source: :follower

  def follow(user_id)
    unless self == user_id
      self.relationships.find_or_create_by(followed_id: user_id.to_i, follower_id: self.id)
    end
  end

  def unfollow(user_id)
    relationships.find_by(followed_id: user_id).destroy
  end

  def following?(user)
    followed_users.include?(user)
  end

  def self.looks(search, word)
    if search == "match"
      @user = User.where("name LIKE?", "#{word}")
    elsif search == "forward"
      @user = User.where("name LIKE?","#{word}%")
    elsif search == "backward"
      @user = User.where("name LIKE?","%#{word}")
    elsif search == "partial"
      @user = User.where("name LIKE?","%#{word}%")
    else
      @user = User.all
    end
  end


  attachment :profile_image, destroy: false

  validates :name, length: {maximum: 20, minimum: 2}, uniqueness: true
  validates :introduction, length: {maximum:50}


end

