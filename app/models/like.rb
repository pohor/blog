class Like < ApplicationRecord
  validates :user, uniqueness: { scope: :article, message: 'Already liked' }
  belongs_to :article
  belongs_to :user
end
