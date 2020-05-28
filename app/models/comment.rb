class Comment < ApplicationRecord
    validates :text, presence: true, length: {minimum: 2}
    belongs_to :post
    belongs_to :user
end
