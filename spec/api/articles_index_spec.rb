RSpec.describe 'GET /api/articles', type: :request do
  subject { response }
  before do
    get '/api/articles'
  end

  it { is_expected.to have_http_status 200 }

  describe 'when there are NO articles in the database' do
    before do
      
    end
  end

end