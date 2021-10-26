require 'stripe_mock'

describe 'POST /api/subscriptions' do
  let(:stripe_helper) { StripeMock.create_test_helper }
  let(:valid_card_token) { stripe_helper.generate_card_token }
  let(:invalid_card_token) { '123456' }

  before do
    StripeMock.create_test_helper
  end

  let(:user) { create(:registered_user) }
  let(:credentials) { user.create_new_auth_token }

  subject { response }

  describe 'with a valid cart token' do
    before do
      post '/api/subscriptions', params: { stripeToken: valid_card_token }, headers: credentials
    end

    it { is_expected.to have_http_status 201 }

    it 'is expected to update the user to subscriber' do
      user.reload
      expect(user.subscriber?).to eq true
    end
  end
end
