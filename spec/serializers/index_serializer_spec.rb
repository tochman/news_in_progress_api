describe Articles::IndexSerializer, type: :serializer do
  let(:article_1) { create(:article) }
  let(:article_2) { create(:article) }
  let(:article_3) { create(:article) }

  let(:serialization) do
    ActiveModelSerializers::SerializableResource.new([article_1, article_2, article_3],
                                                     each_serializer: described_class)
  end

  subject { JSON.parse(serialization.to_json) }

  it 'is expected to wrap content in ' do
    expect(subject.keys).to match ['articles']
  end
  
end
