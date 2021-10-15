describe 'GET api/articles/:id', type: :request do
  subject { response }

  describe 'when the requested article exists in the database' do
    let!(:article) { create(:article) }
    before do
      get "/api/articles/#{article.id}"
    end

    it 'is expected to return an article with the title included' do
      expect(response_json['article']['title']).to eq 'MyTitle'
    end

    it 'is expected to return an article with the lede inculded' do
      expect(response_json['article']['lede']).to eq 'MyLede'
    end

    it 'is expected to return an article with the body included' do
      expect(response_json['article']['body']).to eq 'MyBody'
    end
  end
end
