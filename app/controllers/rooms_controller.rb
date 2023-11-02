class RoomsController < ApplicationController
  before_action :set_room, only: %i[show update destroy]
  before_action :authenticate_user!, only: %i[create update destroy]
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  load_and_authorize_resource

  def index
    @rooms = Room.all
    room_count = @rooms.count
    render json: @rooms, each_serializer: RoomSerializer, status: :ok, count: room_count
  end

  def show
    render json: @room, serializer: RoomSerializer
  end

  def create
    @room = Room.new(room_params)
    if @room.save!
      render json: @room, serializer: RoomSerializer, status: :created
    else
      render json: @room.errors, status: :unprocessable_entity
    end
  end

  def update
    if @room.update(room_params)
      render json: @room, serializer: RoomSerializer
    else
      render json: @room.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @room.destroy
    head :no_content
  end

  private

  def set_room
    @room = Room.find(params[:id])
  end

  def room_params
    params.permit(:description, :capacity, :price, photos: [])
  end
end
