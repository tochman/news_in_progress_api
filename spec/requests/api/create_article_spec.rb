RSpec.describe 'POST /api/articles', type: :request do
  subject { response }
  describe 'when the article is successfully created' do
    before do
      post '/api/articles',
           params: { title: 'Amazing title',
                     lede: 'Amazing lede...' }
    end

    it { is_expected.to have_http_status 201 }

    it 'is expected to return a response message when an article is created' do
      expect(response_json['message']).to eq(
        'You have successfully added Amazing title to the site'
      )
    end
  end

  describe 'when the article is missing' do
    describe 'the title' do
      before do
        post '/api/articles',
             params: { lede: "I'm missing a title" }
      end

      it { is_expected.to have_http_status 422 }

      it 'is expected to to ask for a title when the title is missing' do
        expect(response_json['errors']).to eq(
          "Title can't be blank"
        )
      end
    end

    describe 'the lede' do
      before do
        post '/api/articles',
             params: { title: 'I forgot the lede' }
      end

      it { is_expected.to have_http_status 422 }

      it 'is expected to to ask for a lede when the lede is missing' do
        expect(response_json['errors']).to eq(
          "Lede can't be blank"
        )
      end
    end
  end
end
