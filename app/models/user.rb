class User < ApplicationRecord
    has_secure_password
    has_many :items
    validates :email, presence: true
    validates :name, presence: true

    def self.find_or_create_by_oauth(auth)
        where(email: auth.info.email).first_or_create do |user|
          user.img_url = auth.info.image
          user.name = auth.info.name
          user.email = auth.info.email
          user.password = SecureRandom.hex
        end
    end
    
end
