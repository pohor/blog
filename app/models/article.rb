class Article < ApplicationRecord

  mount_uploader :cover, CoverUploader

  validates :title, presence: true, length: {  minimum: 5 }

  has_many :comments, dependent: :destroy
  belongs_to :user
  has_many :likes
  has_many :users, through: :likes

  scope :published, -> { where(published: true) }

  scope :most_commented, -> { order(comments_count: :desc).first }

  def tags=(tag_list)
    tag_list = sanitize_tags(tag_list) if tag_list.is_a?(String)
    super(tag_list)
  end

  def css_class
    if published?
      'normal'
    else
      'unpublished'
    end
  end

  private

  def sanitize_tags(text)
    text.downcase.split.uniq
  end

end
