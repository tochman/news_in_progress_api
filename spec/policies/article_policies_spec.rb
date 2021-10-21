describe ArticlePolicy do
  describe 'based on roles' do
    subject { described_class.new(user, article) }

    let(:article) { create(:article) }

    describe 'when the user is a user' do
      let(:user) { create(:user) }

      it { is_expected.to permit_actions %i[show index] }
      it { is_expected.to forbid_actions %i[create update destroy] }
    end

    describe 'when the user is a journalist' do
      let(:user) { create(:journalist) }
      let(:article) { create(:article, authors: [user]) }

      it { is_expected.to permit_actions %i[create show index destroy] }
    end

    describe 'when the user is an editor' do
      let(:user) { create(:editor) }

      it { is_expected.to permit_actions %i[create show index destroy] }
    end
  end

  describe ':based on article' do
    let(:journalist_1) { create(:journalist) }
    let(:journalist_2) { create(:journalist) }
    let(:article) { create(:article, authors: [journalist_1]) }
    describe 'the user is not the author of the article' do
      subject { described_class.new(journalist_2, article) }

      it { is_expected.to permit_actions %i[show index] }
      it { is_expected.to forbid_actions %i[update destroy] }
    end

    describe 'the user is the author of the article' do
      subject { described_class.new(journalist_1, article) }

      it { is_expected.to permit_actions %i[show index update destroy] }
      it { is_expected.to_not forbid_actions %i[update destroy] }
    end
  end
end
