class User < ApplicationRecord
  has_many :articles, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_secure_password

  validates :email, presence: true, uniqueness: true, format: {
    with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  }
  validates :user_name, presence: true, uniqueness: true

  def to_param
    user_name
  end

  def username
    "@#{user_name}"
  end

  def no_of_articles
    articles.count
  end
end
