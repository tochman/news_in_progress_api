describe 'GET api/articles/:id', type: :request do
  subject { response }

  describe 'when the article is published' do
    let!(:article) { create(:article) }
    before do
      get "/api/articles/#{article.id}"
    end

    it { is_expected.to have_http_status 200 }

    it 'is expected to return an article with the published status true' do
      expect(response_json['article']['published']).to eq true
    end
  end

  describe 'when the article is not published' do
    let!(:article) { create(:article, published: false)  }
    before do
      get "/api/articles/#{article.id}"
    end

    it { is_expected.to have_http_status 200 }

    it 'is expected to return an article with the published status false' do
      expect(response_json['article']['published']).to eq false
    end
  end
end