RSpec.describe 'POST /api/articles', type: :request do
  subject { response }
  let(:article) { create(:article, title: 'Big News!') }
  describe '' do
    before do
      post '/api/articles',
           params: { title: article.title,
                     lede: article.lede }
    end
    it { is_expected.to have_http_status 201 }

    it 'is expected to return a respomse message when a article is created' do
      expect(response_json['message']).to eq(
        "You have successfully added #{article.title} to the site"
      )
    end
  end
end
