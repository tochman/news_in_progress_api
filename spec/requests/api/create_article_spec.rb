RSpec.describe 'POST /api/articles', type: :request do
  subject { response }
  let(:article) { create(:article, title: 'Big News!') }
  describe 'when the article is successfully created' do
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

  describe 'when the article is missing ' do
    describe 'the title' do
      before do
        post '/api/articles'
      end

      it 'is expected to to ask for a title when the title is missing' do
        expect(response_json['message']).to eq(
          'Please add a title to your article'
        )
      end
    end

    describe 'the lede' do
      before do
        post '/api/articles',
             params: { title: article.title}
      end
      it 'is expected to to ask for a lede when the lede is missing' do
        expect(response_json['message']).to eq(
          'Please add a lede to your article'
        )
      end
    end
  end
end
