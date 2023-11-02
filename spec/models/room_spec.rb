require 'rails_helper'

RSpec.describe Room, type: :model do
  it 'is valid with valid attributes' do
    room = Room.new(
      description: 'A cozy room',
      capacity: 2,
      price: 100.00
    )
    allow(room).to receive_message_chain(:photos, :attached?).and_return(true)
    expect(room).to be_valid
  end

  it 'is not valid without a description' do
    room = Room.new(
      capacity: 2,
      price: 100.00
    )
    allow(room).to receive_message_chain(:photos, :attached?).and_return(true)
    expect(room).to_not be_valid
  end

  it 'is not valid without capacity' do
    room = Room.new(
      description: 'A cozy room',
      price: 100.00
    )
    allow(room).to receive_message_chain(:photos, :attached?).and_return(true)
    expect(room).to_not be_valid
  end

  it 'is not valid without a price' do
    room = Room.new(
      description: 'A cozy room',
      capacity: 2
    )
    allow(room).to receive_message_chain(:photos, :attached?).and_return(true)
    expect(room).to_not be_valid
  end

  it 'is not valid without attached photos' do
    room = Room.new(
      description: 'A cozy room',
      capacity: 2,
      price: 100.00
    )
    allow(room).to receive_message_chain(:photos, :attached?).and_return(false)
    expect(room).to be_valid
  end
end
