require 'stripe_mock'

RSpec.describe 'POST api/subscriptions', type: :request do
  let(:stripe_helper) { StripeMock.create_test_helper }
  let(:valid_card_token) { stripe_helper.generate_card_token }
  let(:invalid_card_token) { '12345' }
  before(:each) do
    StripeMock.start
    
  end
  after(:each) do
    StripeMock.stop
  end

  let(:user) { create(:user) }
  let(:credentials) { user.create_new_auth_token }

  subject { response }
  describe 'with a valid card token' do
    before do
      post '/api/subscriptions',
           params: { stripeToken: valid_card_token },
           headers: credentials
    end

    it { is_expected.to have_http_status 201 }

    it 'is expected tu update user to subscriber' do
      user.reload
      expect(user.subscriber?).to eq true
    end
  end

  describe 'with an invalid card token' do
  end
  
  describe 'a declined card' do    
    before do 
      StripeMock.prepare_card_error(:card_declined)
    end
  end
end
