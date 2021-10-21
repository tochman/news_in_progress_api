RSpec.describe User, type: :model do
  describe 'db table' do
    it {
      is_expected.to have_db_column(:name)
        .of_type(:string)
    }

    it {
      is_expected.to have_db_column(:role)
        .of_type(:integer)
    }
  end

  describe 'factory' do
    describe ':user' do
      it {
        expect(create(:user)).to be_valid
      }
    end
    describe ':editor' do
      it {
        expect(create(:editor)).to be_valid
      }
    end

    describe ':subscriber' do
      it {
        expect(create(:subscriber)).to be_valid
      }
    end

    describe ':journalist' do
      it {
        expect(create(:journalist)).to be_valid
      }
    end
  end

  describe '#role' do
    it { is_expected.to respond_to :registered_user? }
    it { is_expected.to respond_to :registered_user! }

    it { is_expected.to respond_to :journalist? }
    it { is_expected.to respond_to :journalist! }

    it { is_expected.to respond_to :editor? }
    it { is_expected.to respond_to :editor! }

    it { is_expected.to respond_to :subscriber? }
    it { is_expected.to respond_to :subscriber! }

    describe 'class methods' do
      subject { User }
      it { is_expected.to respond_to :registered_user }
      it { is_expected.to respond_to :journalist }
      it { is_expected.to respond_to :editor }
      it { is_expected.to respond_to :subscriber }
    end
  end

  describe 'associations' do
    it { is_expected.to have_and_belong_to_many(:articles) }
    describe 'has many :articles' do
      subject { create(:journalist) }
      let(:user_2) { create(:journalist) }
      let!(:article) { create(:article, authors: [subject, user_2]) }

      it 'is expected to include article in collection' do
        expect(subject.articles).to include article
      end
    end
  end
end
