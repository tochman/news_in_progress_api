describe ArticlePolicy do
  subject { described_class.new(user, article) }

  let(:article) { create(:article) }

  describe 'when the user is a user' do
    let(:user) { create(:user) }

    it { is_expected.to permit_actions %i[show index] }
    it { is_expected.to forbid_new_and_create_actions }
  end

  describe 'when the user is a subscriber' do
    let(:journalist) { create(:user, role: :journalist) }

    it { is_expected.to permit_actions %i[show index] }
    it { is_expected.to forbid_new_and_create_actions }
  end

  describe 'when the user is an editor' do
    let(:editor) { create(:user, role: :editor) }

    it { is_expected.to permit_new_and_create_actions }
  end
end
