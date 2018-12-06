class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :img_url, :email
end
