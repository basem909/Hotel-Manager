class ReservationSerializer < ActiveModel::Serializer
  attributes :room_id, :check_in, :check_out
end
