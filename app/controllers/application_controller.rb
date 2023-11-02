class ApplicationController < ActionController::API
  private

  def record_not_found
    render json: { error: 'Record not found', message: 'Please check your input!' }, status: :not_found
  end
end
