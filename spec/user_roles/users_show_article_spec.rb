RSpec.describe 'GET /api/articles', type: :request do
  subject { response }
  let(:category) { create(:category) }
  let(:credentials) { user.create_new_auth_token }
  let!(:article) { create(:article) }

  before do
    get "/api/articles/#{article.id}",
         headers: credentials
  end

  describe 'successful, for registered users' do
    let(:user) { create(:registered_user) }

    it { is_expected.to have_http_status 200 }

    it 'is expected to return an article' do
      expect(response_json['article']['title']).to eq 'MyTitle'
    end
  end

  describe 'successful, for subscribers' do
    let(:user) { create(:subscriber) }

    it { is_expected.to have_http_status 200 }

    it 'is expected to return an article' do
      expect(response_json['article']['title']).to eq 'MyTitle'
    end
  end

  describe 'successful,for journalists' do
    let(:user) { create(:journalist) }

    it { is_expected.to have_http_status 200 }

    it 'is expected to return an article' do
      expect(response_json['article']['title']).to eq 'MyTitle'
    end
  end

  describe 'successful, for editors' do
    let(:user) { create(:editor) }

    it { is_expected.to have_http_status 200 }

    it 'is expected to return an article' do
      expect(response_json['article']['title']).to eq 'MyTitle'
    end
  end
end
