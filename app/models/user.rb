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

    def auth_options
      super.merge(store: !request.format.json?)
    end
    
end
