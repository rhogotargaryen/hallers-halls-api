class ItemSerializer < ActiveModel::Serializer
    belongs_to :user
    attributes :id, :name, :img_url, :description
  end
  