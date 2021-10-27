describe 'POST /api/subscriptions' do
  let(:stripe_helper) { StripeMock.create_test_helper }
  let(:valid_card_token) { stripe_helper.generate_card_token }
  let(:invalid_card_token) { '123456' }
  let(:user) { create(:registered_user) }
  let(:credentials) { user.create_new_auth_token }

  before(:each) do
    StripeMock.start
  end

  after(:each) do
    StripeMock.stop
  end

  subject { response }

  describe 'successful, with a valid cart token' do
    before do
      post '/api/subscriptions', params: { stripeToken: valid_card_token, currency: 'sek', amount: 2_000 },
                                 headers: credentials
    end

    it { is_expected.to have_http_status 201 }

    it 'is expected to update the user to subscriber' do
      user.reload
      expect(user.subscriber?).to eq true
    end

    it 'is expected to return an success message' do
      expect(response_json['message']).to eq 'You have successfully subscribed.'
    end
  end

  describe 'unsuccessful, with an invalid cart token' do
    before do
      post '/api/subscriptions', params: { stripeToken: invalid_card_token }, headers: credentials
    end

    it { is_expected.to have_http_status 404 }

    it 'is expected to update the user to subscriber' do
      user.reload
      expect(user.subscriber?).to eq false
    end

    it 'is expected to return an error message' do
      expect(response_json['errors']).to eq 'Invalid token id: 123456'
    end
  end

  describe 'unsuccessful, when the card is declined' do
    before do
      StripeMock.prepare_card_error(:card_declined)
      post '/api/subscriptions', params: { stripeToken: valid_card_token }, headers: credentials
    end

    it { is_expected.to have_http_status 402 }

    it 'is expected to return an error message' do
      expect(response_json['errors']).to eq 'The card was declined'
    end
  end

  describe 'unsuccessful, when the card has a processing_error' do
    before do
      StripeMock.prepare_card_error(:processing_error)
      post '/api/subscriptions', params: { stripeToken: valid_card_token }, headers: credentials
    end

    it { is_expected.to have_http_status 402 }

    it 'is expected to return an error message' do
      expect(response_json['errors']).to eq 'An error occurred while processing the card'
    end
  end

  describe 'unsuccessful, when the user does not have the right credentials' do
    before do
      post '/api/subscriptions', params: { stripeToken: valid_card_token }
    end

    it { is_expected.to have_http_status 401 }

    it 'is expected to return an error message' do
      expect(response_json['errors'][0]).to eq 'You need to sign in or sign up before continuing.'
    end
  end
end
