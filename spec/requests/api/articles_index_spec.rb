RSpec.describe 'GET /api/articles', type: :request do
  subject { response }

  describe 'when there are some article in the database' do
    let(:tech) { create(:category, name: 'Tech') }
    let!(:article1) { create(:article, category_id: tech.id, category_name: tech.name) }
    let!(:article2) { create(:article, category_id: tech.id, category_name: tech.name) }
    let!(:article3) { create(:article) }

    describe 'searching for all articles' do
      before do
        get '/api/articles'
      end
      it { is_expected.to have_http_status 200 }

      it 'is expected to return a collection of articles' do
        expect(response_json['articles'].count).to eq 3
      end

      it 'is expected to include a category value' do
        expect(response_json['articles'].last['category_name']).to eq 'MyCategory'
      end
    end

    describe 'search for articles by categories' do
      before do
        get '/api/articles/',
            params: { category_name: tech.name }
      end
      it { is_expected.to have_http_status 200 }

      it 'is expected to return a collection of articles' do
        expect(response_json['articles'].count).to eq 2
      end
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
