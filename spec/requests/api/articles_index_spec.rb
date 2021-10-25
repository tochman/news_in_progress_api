RSpec.describe 'GET /api/articles', type: :request do
  subject { response }

  describe 'when there are some article in the database' do
    let(:journalist) { create(:journalist) }
    let(:category) { create(:category, name: 'Tech') }
    let!(:article_1) { create(:article, category_id: category.id, category_name: category.name) }
    let!(:article_2) { create(:article, category_id: category.id, category_name: category.name) }
    let!(:article_3) { create(:article, authors: [journalist]) }

    describe 'searching for all articles' do
      before do
        get '/api/articles'
      end
      it { is_expected.to have_http_status 200 }

      it 'is expected to return a collection of articles' do
        binding.pry
        expect(response_json['articles'].count).to eq 3
      end

      it 'is expected to include a category value' do
        expect(response_json['articles'].last['category_name']).to eq 'MyCategory'
      end

      it 'is expected to return an article with the published status true' do
        expect(response_json['articles'].last['published']).to eq true
      end

      it 'is expected to return the author of the article' do
        expect(response_json['articles'].last['authors'].last['name']).to eq journalist.name
      end
    end

    describe 'search for articles by categories' do
      before do
        get '/api/articles/',
            params: { category_name: category.name }
      end
      it { is_expected.to have_http_status 200 }

      it 'is expected to return a collection of articles' do
        expect(response_json['articles'].count).to eq 2
      end
    end

    describe 'when the category params dont exist' do
      before do
        get '/api/articles/',
            params: { category_name: 'Sports' }
      end

      it 'is expected to return a collection of articles' do
        expect(response_json['articles'].count).to eq 3
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

  describe 'when the article is not published' do
    let!(:article_4) { create(:article, published: false) }
    let!(:article_5) { create(:article) }
    before do
      get '/api/articles/'
    end

    it { is_expected.to have_http_status 200 }

    it 'is expected to NOT return an unpublished article' do
      expect(response_json['articles'].count).to eq 1
    end
  end
end
