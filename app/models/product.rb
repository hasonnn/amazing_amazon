class Product < ApplicationRecord
    belongs_to :user
    
    has_many :reviews, dependent: :destroy

    has_many :favorites, dependent: :destroy
    has_many :favoriters, through: :favorites, source: :user

    has_many :taggings, dependent: :destroy
    has_many :tags, through: :taggings

    DEFAULT_PRICE = 1

    before_validation :set_default_price
    before_save :capitalize_title

    validates :title, presence: true, uniqueness: true
    validates :price, numericality: { greater_than: 0 }
    validates :description, presence: true, length: { minimum: 2 }

    #Getter
    def tag_names
        self.tags.map(&:name).join(", ")
    end

    #Setter
    def tag_names=(rhs)
        self.tags = rhs.strip.split(/\s*,\s*/).map do |tag_name|
        Tag.find_or_initialize_by(name: tag_name)
        end
    end

    private
    def set_default_price
        self.price ||= DEFAULT_PRICE
    end
    
    def capitalize_title
        self.title.capitalize!
    end
end
