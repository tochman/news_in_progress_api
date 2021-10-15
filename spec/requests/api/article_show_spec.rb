describe 'GET api/articles/:id', type: :request do
  subject { response }

  describe 'when the requested article exists in the database' do
    let!(:article) { create(:article) }
    before do
      get '/api/articles/1'
    end

    it 'is expected to return an article with the title included' do
      binding.pry
      expect(response_json['article']['title']).should eq 'MyTitle'
    end
  end
end
