class Product < ApplicationRecord
    belongs_to :user
    
    has_many :reviews, dependent: :destroy

    DEFAULT_PRICE = 1

    before_validation :set_default_price
    before_save :capitalize_title

    validates :title, presence: true, uniqueness: true
    validates :price, numericality: { greater_than: 0 }
    validates :description, presence: true, length: { minimum: 2 }

    private
    def set_default_price
        self.price ||= DEFAULT_PRICE
    end
    
    def capitalize_title
        self.title.capitalize!
    end
end
