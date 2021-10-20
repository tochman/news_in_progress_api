describe ArticlePolicy do
  subject { described_class.new(user, article) }

  let(:article) { create(:article) }

  describe 'when the user is a user' do
    let(:user) { create(:user) }

    it { is_expected.to permit_actions %i[show index] }
    it { is_expected.to forbid_actions %i[create] }
  end

  describe 'when the user is a journalist' do
    let(:journalist) { create(:journalist) }

    it { is_expected.to permit_actions %i[create show index] }
  end

  describe 'when the user is an editor' do
    let(:editor) { create(:editor) }

    it { is_expected.to permit_actions %i[create show index] }
  end
end
