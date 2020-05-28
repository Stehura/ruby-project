class User < ApplicationRecord
    validates :username, presence: true, length: {minimum: 3, maximum: 32} 
    validates :password, presence: true, length: {minimum: 6, maximum: 32}
    has_many :posts, dependent: :destroy
end
