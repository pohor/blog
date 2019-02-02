class Score < ApplicationRecord
  validates :user, uniqueness: { scope: :comment, message: 'Already Scored' }
  belongs_to :comment
  belongs_to :user

  scope :for_user, -> (current_user){ where(user: current_user).first }
end
