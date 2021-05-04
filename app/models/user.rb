class User < ApplicationRecord
    has_secure_password

    has_many :products, dependent: :nullify
    has_many :reviews, dependent: :nullify
    has_many :news_articles, dependent: :nullify
    
    has_many :likes, dependent: :destroy
    has_many :liked_reviews, through: :likes, source: :review
    
    has_many :favorites, dependent: :destroy
    has_many :favorited_products, through: :favorites, source: :product

    has_many :votes, dependent: :destroy 
    has_many :voted_reviews, through: :votes, source: :review

    def full_name
        "#{first_name} #{last_name}"
    end
end
