RSpec.describe 'GET /api/articles', type: :request do
  subject { response }

  describe 'when there are some article in the database' do
    let!(:articles) { create_list(:article, 2) }
    before do
      get '/api/articles'
    end
    it { is_expected.to have_http_status 200 }

    it 'is expected to return a collection of articles' do
      expect(response_json['articles'].count).to eq 2
    end
  end

  describe 'when there are no articles in the database' do
    before do
      get '/api/articles'
    end

    it { is_expected.to have_http_status 404 }

    it 'is expected to respond with a negative message when no articles are found' do
      expect(response_json['message']).to eq 'There are no articles in the database'
    end
  end
end
