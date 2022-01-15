class Article < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :users, through: :likes

  def days_ago
    time = (Time.current - created_at) / (60 * 60)
    return_string = "#{time.round} #{time > 1 ? 'hours' : 'hour'}"
    if time >= 24
      days = (time / 24).round
      hours = (time % 24).round
      return_string = "#{days} #{days > 1 ? 'days' : 'day'} #{hours} #{hours > 1 ? 'hours' : 'hour'}"
    end
    "#{return_string} ago"
  end

  def liked?(current_user)
    # raise
    (users.include? current_user)
  end
end
