class User < ApplicationRecord

    has_secure_password
  
    has_many :products, dependent: :nullify
    has_many :reviews, dependent: :destroy
  
  
    has_many :likes, dependent: :destroy
    has_many :liked_reviews, through: :likes, source: :review
  
    # Validations
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
    validates :first_name, :last_name, presence: true
    validates :email, presence: true, uniqueness: true, format: VALID_EMAIL_REGEX
  
    scope(:created_after, -> (date) { where("created_at < ?", "#{date}") })
    scope(:search, -> (query) { where("first_name ILIKE ? OR last_name ILIKE ? OR email ILIKE ?", "%#{query}%", "%#{query}%", "%#{query}%") })
  
    def full_name
      "#{first_name} #{last_name}".strip.titleize
    end
  end