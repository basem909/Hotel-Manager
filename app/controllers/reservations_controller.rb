# app/controllers/api/v1/reservations_controller.rb

class ReservationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_reservation, only: [:show, :update, :destroy]

  def index
    @reservations = current_user.reservations
    render json: @reservations, status: :ok
  end

  def show
    render json: @reservation, status: :ok
  end

  def create
    room = Room.find(params[:room_id])
    check_in = params[:check_in]
    check_out = params[:check_out]

    @reservation = current_user.reservations.build(room: room, check_in: check_in, check_out: check_out)

    if @reservation.save
      render json: @reservation, status: :created
    else
      render json: @reservation.errors, status: :unprocessable_entity
    end
  end

  def update
    if @reservation.update(reservation_params)
      render json: @reservation, status: :ok
    else
      render json: @reservation.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @reservation.destroy
    head :no_content
  end

  private

  def set_reservation
    @reservation = current_user.reservations.find(params[:id])
  end

  def reservation_params
    params.permit(:check_in, :check_out)
  end
end
