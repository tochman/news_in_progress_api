RSpec.describe 'POST /api/auth/' do
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
end
