RSpec.describe Article, type: :model do
  describe 'DB table' do
    it { is_expected.to have_db_column :title }
    it { is_expected.to have_db_column :lede }
    it { is_expected.to have_db_column :body }
    it { is_expected.to have_db_column :category}
  end

  describe 'Validations' do
    it { is_expected.to validate_presence_of :title }
    it { is_expected.to validate_presence_of :lede }
    it { is_expected.to validate_presence_of :body }
    it { is_expected.to validate_presence_of :category }
  end

  describe 'Factory' do
    it 'is expected to have valid Factory' do
      expect(create(:article)).to be_valid
    end
  end
end
