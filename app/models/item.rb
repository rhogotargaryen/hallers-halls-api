class Item < ApplicationRecord
    belongs_to :user
    validates :name, presence: true, uniqueness: true
    validates :price, presence: true
end


