class RoomSerializer < ActiveModel::Serializer
  attributes :description, :price, :capacity
end
