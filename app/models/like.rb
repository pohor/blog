class Like < ApplicationRecord
  validates :user, uniqueness: { scope: :article, message: 'Already liked' }
  belongs_to :article, counter_cache: true
  belongs_to :user
end
