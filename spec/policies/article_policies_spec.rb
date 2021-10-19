describe ArticlePolicy do
  subject { described_class.new(user, article) }

  let(:article) { create(:article) }

  describe 'when the user is a visitor' do
    let(:user) { create(:users, role: 'visitor') }

    it { is_expected.to permit_actions %i[show index] }
    it { is_expected.to forbid_new_and_create_actions }
  end

  describe 'when the user is a subscriber' do
    let(:user) { create(:users, role: 'subscriber') }

    it { is_expected.to permit_actions %i[show index] }
    it { is_expected.to forbid_new_and_create_actions }
  end

  describe 'when the user is an journalist' do
    let(:user) { create(:users, role: 'journalist') }

    it { is_expected.to permit_new_and_create_actions }
  end

  describe 'when the user is an editor' do
    let(:user) { create(:users) }

    it { is_expected.to permit_new_and_create_actions }
    it { is_expected.to permit_new_and_create_actions }
  end
end
