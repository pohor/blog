class Comment < ApplicationRecord
  include ActiveModel::Validations

  validates :body, presence: true, length: 6..500
  belongs_to :article, counter_cache: true
  belongs_to :user

  has_many :scores
  has_many :users, through: :scores


  def score_value
    score_value = 0
    scores.each do |score|
      score_value += score.value
    end
    return score_value
  end



end
