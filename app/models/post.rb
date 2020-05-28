class Post < ApplicationRecord
    validates :title, presence: true, length: {minimum: 3, maximum: 256}
    validates :category, presence: true, length: {minimum: 3, maximum: 256}
    validates :text, presence: true, length: {minimum: 3}
    belongs_to :user
    has_many :comments, dependent: :destroy
end
