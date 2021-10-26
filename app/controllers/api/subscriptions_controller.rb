class Api::SubscriptionsController < ApplicationController
before_action :authenticate_user!, only: :create
  rescue_from Stripe::CardError, with: :rescue

  def create
    customer = Stripe::Customer.list(email: current_user.email).data.first
    customer ||= Stripe::Customer.create(email: current_user.email, source: params[:stripeToken]) unless customer
    payment = Stripe::Charge.create(customer: customer.id, currency: 'sek', amount: 50_000)
    if payment[:paid]
      render json: {message: 'You have successfully subscribed'}, status: 201
      current_user.subscriber!
    else
      render json: {error: 'Something went wrong!'}, status: 422
    end

  end

  private

  def rescue(e)
    binding.pry
    render json: {error: e.message}, status: 402
  end
end
