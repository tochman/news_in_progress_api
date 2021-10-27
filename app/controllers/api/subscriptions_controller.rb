class Api::SubscriptionsController < ApplicationController
  before_action :authenticate_user!, only: :create
  rescue_from Stripe::StripeError, with: :rescue

  def create
    customer = Stripe::Customer.list(email: current_user.email).data.first
    customer ||= Stripe::Customer.create(email: current_user.email, source: params[:stripeToken])
    Stripe::Charge.create(customer: customer.id, currency: params[:currency], amount: params[:amount].to_i)

    current_user.subscriber!
    render json: { message: 'You have successfully subscribed.' }, status: 201
  end

  private

  def rescue(e)
    render json: { errors: e.message }, status: e.http_status
  end
end
