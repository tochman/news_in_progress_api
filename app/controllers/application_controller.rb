class ApplicationController < ActionController::API
  before_action :configure_permitted_parameters, if: :devise_controller?
        include DeviseTokenAuth::Concerns::SetUserByToken
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found_error
rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

include Pundit

  private

  def user_not_authorized
    render json: { errors: 'You are not authorized to perfom that action.' }, status: 401
  end

  def record_not_found_error
    render json: { errors: 'Your request could not be processed.' }, status: 422
  end
		
	def configure_permitted_parameters
		devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
	end
end
