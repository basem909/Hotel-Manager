# app/controllers/api/v1/reservations_controller.rb

class ReservationsController < ApplicationController
  load_and_authorize_resource
  before_action :authenticate_user!
  before_action :set_reservation, only: %i[show update destroy]
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def index
    if current_user.admin?
      @reservations = Reservation.all
    else
      @reservations = current_user.reservations
    end
    render json: @reservations, each_serializer: ReservationSerializer, status: :ok
  end

  def show
    render json: @reservation, status: :ok
  end

  def create
    room = Room.find(params[:room_id])
    check_in = params[:check_in]
    check_out = params[:check_out]

    @reservation = current_user.reservations.build(room:, check_in:, check_out:)

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
    @reservation = current_user.admin? ? Reservation.find(params[:id]) : current_user.reservations.find(params[:id])
  end

  def reservation_params
    params.permit(:check_in, :check_out, :id)
  end
end
