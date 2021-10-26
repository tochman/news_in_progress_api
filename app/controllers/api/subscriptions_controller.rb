class Api::SubscriptionsController < ApplicationController
  before_action :authenticate_user!, only: :create
  rescue_from Stripe::CardError, with: :rescue
  rescue_from Stripe::InvalidRequestError, with: :rescue

  def create
    customer = Stripe::Customer.list(email: current_user.email).data.first
    customer ||= Stripe::Customer.create(email: current_user.email, source: params[:stripeToken]) unless customer
    Stripe::Charge.create(customer: customer.id, currency: 'sek', amount: 50_000)

    render json: { message: 'You have successfully subscribed' }, status: 201
    current_user.subscriber!
  end

  private

  def rescue(e)
    render json: { errors: e.message }, status: e.http_status
  end
end
