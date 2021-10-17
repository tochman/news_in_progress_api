RSpec.describe 'POST /api/auth/' do
  subject { response }
  describe 'successful registration' do
    before do
      post '/api/auth/',
           params: {
             email: 'user@email.com',
             name: 'foobar',
             password: 'password',
             password_confirmation: 'password',
             confirmation_success_url: 'placeholder'
           }
    end

    it { is_expected.to have_http_status 200 }

    it 'is expected to return an access token to the user' do
      expect(response.header['access-token']).not_to eq nil
    end

    it 'is expected to that users database contains new user' do
      expect(User.all.first.email).to eq 'user@email.com'
    end
  end

  describe 'unsuccessful registration' do
    before do
      post '/api/auth/',
           params: {
             email: 'user@email.com',
             name: 'foobar',
             password: 'passsword',
             password_confirmation: 'wrong password',
             confirmation_success_url: 'placeholder'
           }
    end

    it 'is expected to return a error message when password do not match' do
      expect(response_json['errors']['full_messages']).to eq ["Password confirmation doesn't match Password"]
    end
  end
end
