require 'rails_helper'

RSpec.describe Reservation, type: :model do
  it 'is valid with valid attributes' do
    user = create(:user)
    room = create(:room)

    reservation = Reservation.new(
      user:,
      room:,
      check_in: Date.today,
      check_out: Date.tomorrow
    )

    expect(reservation).to be_valid
  end

  it 'is not valid without a user' do
    room = create(:room)

    reservation = Reservation.new(
      room:,
      check_in: Date.today,
      check_out: Date.tomorrow
    )

    expect(reservation).not_to be_valid
  end

  it 'is not valid without a room' do
    user = create(:user)

    reservation = Reservation.new(
      user:,
      check_in: Date.today,
      check_out: Date.tomorrow
    )

    expect(reservation).not_to be_valid
  end

  it 'is not valid without check-in' do
    user = create(:user)
    room = create(:room)

    reservation = Reservation.new(
      user:,
      room:,
      check_out: Date.tomorrow
    )

    expect(reservation).not_to be_valid
  end

  it 'is not valid without check-out' do
    user = create(:user)
    room = create(:room)

    reservation = Reservation.new(
      user:,
      room:,
      check_in: Date.today
    )

    expect(reservation).not_to be_valid
  end
end
