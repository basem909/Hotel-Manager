# app/models/reservation.rb

class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :room

  validates :check_in, :check_out, presence: true
  validate :check_in_is_before_check_out
  validate :no_overlapping_reservations
  validate :check_in_is_not_in_past

  private

  # Custom validation to ensure check_in is before check_out
  def check_in_is_before_check_out
    return if check_in.nil? || check_out.nil?

    return unless check_in >= check_out

    errors.add(:check_in, 'must be before check-out')
  end

  # Custom validation to prevent overlapping reservations for the same room
  def no_overlapping_reservations
    return if room.nil? || check_in.nil? || check_out.nil?

    overlapping_reservations = Reservation
      .where(room_id:)
      .where.not(id:) # Exclude self if updating
      .where('check_in < ? AND check_out > ?', check_out, check_in)

    return unless overlapping_reservations.exists?

    errors.add(:base, 'Overlapping reservation for the same room')
  end

  # Custom validation to prevent reservations in the past
  def check_in_is_not_in_past
    return if check_in.nil?

    return unless check_in < Date.today

    errors.add(:check_in, 'must not be in the past')
  end
end
