class Like < ApplicationRecord
  belongs_to :user
  belongs_to :article
  validates :user, presence: true
  validates :article, presence: true
  validates :user, uniqueness: { scope: :article }
  # should have unique combination of user and article for each like
end
