FactoryBot.define do
  factory :article do
    title { 'MyTitle' }
    lede { 'MyLede' }
    body { 'MyBody' }
    category_id { 2 }
  end
end
