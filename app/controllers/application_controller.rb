class ApplicationController < ActionController::API
        include DeviseTokenAuth::Concerns::SetUserByToken
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found_error

  private

  def record_not_found_error
    render json: { errors: 'Your request could not be processed.' }, status: 422
  end
end
