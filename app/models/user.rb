class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable


  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :article
  has_many :comments
  has_many :likes
  has_many :liked_articles, through: :likes, source: :article

  has_many :scores
  has_many :scored_comments, through: :scores, source: :comment

  def admin?
    admin
  end

end
