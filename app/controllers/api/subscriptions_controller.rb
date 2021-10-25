class Api::SubscriptionsController < ApplicationController
  before_action :authenticate_user!, only: :create
  rescue_from Stripe::CardError, with: :rescue
  def create
    customer = Stripe::Customer.list(email: current_user.email).data.first
    customer ||= Stripe::Customer.create(email: current_user.email, source: params[:stripeToken])
    payment = Stripe::Charge.create(customer: customer.id, currency: 'sek', amount: 50_000)
    if payment[:paid]
      # we need to update the user to a subscriber
      current_user.subscriber!
      render json: { message: 'all good' }, status: 201
    else
      render json: { error: 'not good' }, status: 422
    end
  end

  private

  def rescue(e)
    render json: { error: e.message }, status: 422
  end
end
