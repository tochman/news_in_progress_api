describe ArticlePolicy do
  subject { described_class.new(user, article) }

  let(:article) { create(:article) }

  describe 'when the user is a user' do
    let(:user) { create(:user) }

    it { is_expected.to permit_actions %i[show index] }
    it { is_expected.to forbid_actions %i[create update destroy] }
  end

  describe 'when the user is a journalist' do
    let(:user) { create(:journalist) }

    it { is_expected.to permit_actions %i[create show index destroy] }
  end

  describe 'when the user is an editor' do
    let(:user) { create(:editor) }

    it { is_expected.to permit_actions %i[create show index destroy] }
  end
end
