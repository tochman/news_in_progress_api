describe 'POST /api/subscriptions' do
  let(:stripe_helper) { StripeMock.create_test_helper }
  let(:valid_card_token) { stripe_helper.generate_card_token }
  let(:invalid_card_token) { '123456' }

  before(:each) do
        StripeMock.start
  end

  after(:each) do
    StripeMock.stop
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

  describe 'when the card is declined' do
    before do 
      StripeMock.start
    end
    StripeMock.prepare_card_error(:card_declined)
    it { is_expected.to have_http_status 422 }

    it 'is expected to return an error message when the card is declined' do
      expect(response_json["error"]).to eq ""
    end
  end
end
