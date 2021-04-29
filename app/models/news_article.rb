class NewsArticle < ApplicationRecord
    belongs_to :user
    validates :title, presence: true, uniqueness: true
    validates :description, presence: true 
    validate :published_after_create
  
    before_save :titleize_title
  
    def titleize_title
      self.title = self.title.titleize
    end
  
    def publish
      update(published_at: Time.zone.now)
    end
  
    def self.published
      where('published_at > created_at')
    end
  
    private
  
    def published_after_create
      return unless published_at.present?
      errors.add(:published_at, "published_at must be after created_at") if published_at <= created_at 
    end
end
