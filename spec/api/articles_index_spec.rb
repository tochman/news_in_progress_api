RSpec.describe 'GET /api/articles', type: :request do
  subject { response }
  before do
    get '/api/articles'
  end

  it { is_expected.to have_http_status 200 }

  describe 'when there are some articles in the database' do
    let!(:articles) do
      create_list(:article, 2)
    end

    before do
      get '/api/articles'
    end

    it 'is expected to return a collection of articles' do
      expect(response_json['articles'].count).to eq 2
    end
  end

  describe 'when there are no articles in the database' do
    before do
      Article.delete_all
    end

    it 'is expected to respond with a negative message when no articles are found' do
      expect(response_json['message']).to eq 'There are no articles in the database'
    end
  end
end
