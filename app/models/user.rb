class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :validatable,
         :jwt_authenticatable, 
         jwt_revocation_strategy: JWTBlacklist
         

    has_many :items
    validates :email, presence: true
    validates :name, presence: true

    def on_jwt_dispatch(token, payload)
      puts("********* toaken dispatched *************")
      puts(token)
    end

    def self.from_omniauth(auth)
      where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
        user.email = auth.info.email
        user.password = Devise.friendly_token[0,20]
        user.name = auth.info.name   # assuming the user model has a name
        user.img_url = auth.info.image # assuming the user model has an image
        # If you are using confirmable and the provider(s) you use validate emails, 
        # uncomment the line below to skip the confirmation emails.
        # user.skip_confirmation!
      end
    end

    def auth_options
      super.merge(store: !request.format.json?)
    end
    
end
